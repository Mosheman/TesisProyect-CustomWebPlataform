class VisualToolController < ApplicationController
	layout "visual"

	def index

	end

	def massive_push

	end

	def inner_receiver
		search_ids = params["search_ids"]
		# collection = { :tweets => [], :tusers => [] }
		package = Package.new
		current_user.packages << package
		searches = search_ids.blank? ? [] : Search.find(search_ids)
		searches.each do |search|
			if search.search_type == "tusers"
				package.twitter_users << search.twitter_users
			elsif search.search_type == "keywords"
				package.tweets << search.tweets
			end
		end
		redirect_to visual_tool_received_path(package.id)
	end

	def received
		binding.pry
		@packages = current_user.packages
	end

	def tweets_viewer
		@visual_tweets = []
	end

	def users_viewer
		@visual_users = []
	end

	def tweets_visualizer

	end

	def users_visualizer

	end
end
