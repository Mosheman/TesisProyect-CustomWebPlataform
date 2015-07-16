class SearchesController < ApplicationController
	def index	
		n_calls = rate_limit_status	
		@n_calls = 4
	end
	def client_credentials
		# client = Twitter::Streaming::Client.new do |config|
		# 	config.consumer_key        = "Wv70LcNQykkoeoafhYLNPVY0e"
		# 	config.consumer_secret     = "kYzRMrmvRgFAcfTEzpG9NPwCefdcq1WVZILjpsjIatV7duWVZX"
		# 	config.access_token        = "829827006-Ka9rG7rpPBseo75hWyPBHTWduNd9qX8C8g5FMozj"
		# 	config.access_token_secret = "Tlz6Gyaee2k0gifcali2hPz7ImyXot1eH4grv2HUe9QoH"
		# end
	end
	def rate_limit_status
		
	end
	def search
		@key_words = params[:key_words]

		respond_to do |format|
			format.js
		end
	end
end
