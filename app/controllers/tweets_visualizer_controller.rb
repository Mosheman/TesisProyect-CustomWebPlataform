class TweetsVisualizerController < ApplicationController
	layout "visual"

	def index
		tweets = Array.new
		if params["package_ids"]
			tweets = get_tweets_from_packages params["package_ids"]
		elsif params["study_ids"]
    	tweets = get_tweets_from_studies params["study_ids"]
		end

	  	@markers = get_markers_from_tweets(tweets)
	  	if @markers.any?
		  	@first_date = @markers.first.created_at
		  	@last_date = @markers.last.created_at
		  	@years = (@first_date.year..@last_date.year).to_a
		  	@months = []
		  	(@first_date.month..@last_date.month).each {|m| @months << {id: m, name: Date::MONTHNAMES[m]} }
		else
			redirect_to visual_tool_index_path
		end
	end

	def get_markers_from_tweets tweets
		markers = Array.new
		tweets.each do |tweet|
			markers << Marker.new(:owner => tweet.twitters_tweet[:user][:screen_name],
							:owner_id => tweet.twitters_tweet[:user][:id_str],
							:text => tweet.twitters_tweet[:text],
							:lat => tweet.get_latitude,
							:lng => tweet.get_longitude,
							:tweet_id => tweet.twitters_tweet[:id_str],
							:inner_tweet_id => tweet.id,
							:package_id => tweet.package,
							:created_at => tweet.twitters_tweet[:created_at],
							:infowindow => TweetsVisualizerHelper.get_infowindow_from_tweet(tweet)
						)

		end
		markers.sort_by{|m| m[:created_at]}
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
