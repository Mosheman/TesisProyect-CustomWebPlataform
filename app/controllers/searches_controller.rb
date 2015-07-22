class SearchesController < ApplicationController
	before_action :set_search, only: [:show, :edit, :update, :destroy]

  	def client_credentials
		
	end
	def rate_limit_status
		
	end
	def searching
		@key_words = params[:key_words]
		@stop_period = params[:stop_period]
		@stop_data = params[:stop_data]

		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = current_user.twitter_credential.consumer_key
			config.consumer_secret     = current_user.twitter_credential.consumer_secret
			config.access_token        = current_user.twitter_credential.access_token
			config.access_token_secret = current_user.twitter_credential.access_token_secret
		end
		logger.info "--------------> Pasó por SEARCH: "+params.to_s
		respond_to do |format|
			format.js
		end
	end

	# GET /searches
	# GET /searches.json
	def index
		@searches = Search.all
		@search = Search.new

		n_calls = rate_limit_status	
		@n_calls = 4
	end

	# GET /searches/1
	# GET /searches/1.json
	def show
	end

	# GET /searches/new
	def new
		@search = Search.new
	end

	# GET /searches/1/edit
	def edit
	end

	# POST /searches
	# POST /searches.json
	def create
		current_user.searches << Search.new(search_params)
		@search = current_user.searches.last
		respond_to do |format|
		  if @search.save
		    format.html { redirect_to @search, notice: 'Search was successfully created.' }
		    format.json { render :show, status: :created, location: @search }
		  else
		    format.html { render :new }
		    format.json { render json: @search.errors, status: :unprocessable_entity }
		  end
		end
	end

	# PATCH/PUT /searches/1
	# PATCH/PUT /searches/1.json
	def update
		respond_to do |format|
		  if @search.update(search_params)
		    format.html { redirect_to @search, notice: 'Search was successfully updated.' }
		    format.json { render :show, status: :ok, location: @search }
		  else
		    format.html { render :edit }
		    format.json { render json: @search.errors, status: :unprocessable_entity }
		  end
		end
	end

	# DELETE /searches/1
	# DELETE /searches/1.json
	def destroy
		@search.destroy
		respond_to do |format|
		  format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
		  format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
		def set_search
		  @search = current_user.searches.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def search_params
		  params.permit(:search_type, :keywords, :georeference, :depth_level, :data_stop, :time_stop, :ilimited)
		end
end
