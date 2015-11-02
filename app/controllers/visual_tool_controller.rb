class VisualToolController < ApplicationController
	layout "visual"
	
	def index
		
	end
	
	def massive_push
		
	end

	def received
		@packages = []
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
