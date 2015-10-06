class TweetSearchWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false
	
	def perform user_id, search_id, query, geocode, lang

		client = get_client_credentials user_id["$oid"]
		# => Getting rate limits status
		max_attempts = 179
		num_attempts = 0

		@search = Search.find search_id["$oid"] 
		begin
			if lang
				tweets_retrived = client.search(query, result_type: @search.result_type, geocode: geocode, lang: lang).take(180).collect
			else
				tweets_retrived = client.search(query, result_type: @search.result_type, geocode: geocode).take(180).collect
			end				
			tweets_retrived.each do |tweet| 
				num_attempts += 1
				@search.tweets << Tweet.new(twitters_tweet: tweet.to_hash)
			end	
		rescue Twitter::Error::TooManyRequests => error
			if num_attempts <= max_attempts
			# NOTE: Your process could go to sleep for up to 15 minutes but if you
			# retry any sooner, it will almost certainly fail with the same exception.
			    sleep error.rate_limit.reset_in
				retry
			else
				raise
			end
		end
	end
	def get_client_credentials user_id
		user = User.find user_id
		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = user.twitter_credential.consumer_key
			config.consumer_secret     = user.twitter_credential.consumer_secret
			config.access_token        = user.twitter_credential.access_token
			config.access_token_secret = user.twitter_credential.access_token_secret
		end
		return client
	end
end