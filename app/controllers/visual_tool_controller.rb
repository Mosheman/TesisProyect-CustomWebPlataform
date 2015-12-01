class VisualToolController < ApplicationController
	layout "visual"

	def index

	end

	def massive_push

	end

	def inner_receiver
		search_ids = params["search_ids"]
		package = Package.new
		package.transmitter = :inner
		current_user.packages << package

		package.allocate_data search_ids

		redirect_to packages_path
	end

	def received
		@packages = current_user.packages
	end


	def visualizer_dispatcher
		visualizer_type = params["visualizer_type"]
		# => TODO: Limit to 20 package selections
		package_ids = params["package_ids"]

		redirect_to tweets_visualizer_index_path(package_ids: package_ids)
	end

	def tweets_viewer
		@visual_tweets = []
	end

	def users_viewer
		@visual_users = []
	end

end
