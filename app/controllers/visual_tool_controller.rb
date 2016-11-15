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
		#visualizer_type = params["visualizer_type"]
		# => TODO: Limit to 20 package selections
		package_ids = params["package_ids"]
		packages = Package.find(package_ids)
		# Validation if all are the same data_type
		have_same_type = Package.find(package_ids).map(&:data_type).uniq.length == 1
		if !packages.blank? and have_same_type
			if packages.first.data_type == "tweets"
				redirect_to tweets_visualizer_index_path(package_ids: package_ids)
			elsif packages.first.data_type == "tusers"
				redirect_to tusers_visualizer_index_path(package_ids: package_ids)
			end
		else
			redirect_to packages_path
		end
	end

	def tweets_viewer
		@visual_tweets = []
	end

	def users_viewer
		@visual_users = []
	end

end
