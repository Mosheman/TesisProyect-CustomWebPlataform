class TwitterCredential 
	include Mongoid::Document

	field :consumer_key, type: String
	field :consumer_secret, type: String
	field :access_token, type: String
	field :access_token_secret, type: String

	validates :consumer_key, presence: true
	validates :consumer_secret, presence: true

	embedded_in :user
	has_many :twitter_requests

	def get_client
		current_client = Twitter::REST::Client.new do |config|
			config.consumer_key        = user.twitter_credential.consumer_key
			config.consumer_secret     = user.twitter_credential.consumer_secret
			config.access_token        = user.twitter_credential.access_token
			config.access_token_secret = user.twitter_credential.access_token_secret
		end  
		current_client
	end

	def set_request search_id
		search = Search.find search_id
		calls_count = search ? search.get_calls : 0
		request = TwitterRequest.new search: search, calls: calls_count
		twitter_requests << request
	end

end
