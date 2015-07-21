class SearchesController < ApplicationController
	def index	
		n_calls = rate_limit_status	
		@n_calls = 4
	end
	def client_credentials
		
	end
	def rate_limit_status
		
	end
	def search
		@key_words = params[:key_words]
		@stop_period = params[:stop_period]
		@stop_data = params[:stop_data]

		respond_to do |format|
			format.js
		end
	end
end
