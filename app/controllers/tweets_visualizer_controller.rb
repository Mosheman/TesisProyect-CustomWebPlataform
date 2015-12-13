class TweetsVisualizerController < ApplicationController

	def index
		tweets = Array.new
		if params["package_ids"]
			tweets = get_tweets_from_packages params["package_ids"]
		elsif params["study_ids"]
	    	tweets = get_tweets_from_studies params["study_ids"]
		end

    	@markers = get_markers_from_tweets(tweets)
	end

	def get_markers_from_tweets tweets
		markers = Array.new
		tweets.each do |tweet|
			markers << Marker.new(:owner => tweet.twitters_tweet[:user][:screen_name],
							:owner_id => tweet.twitters_tweet[:user][:id_str],
							:text => tweet.twitters_tweet[:text],
							:lat => tweet.twitters_tweet[:geo][:coordinates][0],
							:lng => tweet.twitters_tweet[:geo][:coordinates][1],
							:tweet_id => tweet.twitters_tweet[:id_str],
							:inner_tweet_id => tweet.id,
							:package_id => tweet.package,
							:infowindow => TweetsVisualizerHelper.get_infowindow_from_tweet(tweet)
							)
		end
		markers
	end

	def get_tweets_from_packages package_ids
		tweets = Array.new
		packages = current_user.packages.find package_ids
		packages.each do |package|
			tweets += package.tweets
    	end
    	tweets
	end

	def get_tweets_from_studies study_ids
		tweets = Array.new
    	studies = current_user.studies.find study_ids
    	studies.each do |study|
    		tweets += get_tweets_from_packages study.packages.pluck(:id)
		end
		tweets
	end
end
