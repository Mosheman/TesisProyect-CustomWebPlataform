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


	def action_dispatcher
		package_ids = params["package_ids"]
		if params["visualize"]
			tweets = Array.new
			tusers = Array.new
			packages = current_user.packages.find package_ids
			packages.each do |package|
				if package.data_type == :tweets
					tweets << package.tweets
				elsif package.data_type == :tusers
					tusers << package.tusers
				end
					
	    	end
		elsif params["new_study"]
		  
		end

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
