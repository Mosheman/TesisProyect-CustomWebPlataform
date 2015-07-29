class SearchesController < ApplicationController
	before_action :set_search, only: [:show, :edit, :update, :destroy]

	def rate_limit_status
		
	end
  	def get_client_credentials
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = current_user.twitter_credential.consumer_key
			config.consumer_secret     = current_user.twitter_credential.consumer_secret
			config.access_token        = current_user.twitter_credential.access_token
			config.access_token_secret = current_user.twitter_credential.access_token_secret
		end
		return @client
	end
	def start_search
		# => Params raw
		keywords_raw = @search.keywords
		latitude_raw = @search.latitude
		longitude_raw = @search.longitude
		radius_raw = @search.radius

		# => Parser keywords
		# Replaces all blanks+ and end of lines, for single-space. 
		keywords_space_separated = keywords_raw.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '')
		keywords_array = keywords_space_separated.split(" ")
		# String <- Coma separated keywords
		keywords_str = keywords_array.join(",")

		# => Parser geocode
		geocode_str = latitude_raw.to_s + "," + longitude_raw.to_s + "," + radius_raw.to_s + "km"

		# => Getting credentials
		@client = get_client_credentials

		# => Getting rate limits status
		max_attempts = 100
		num_attempts = 0
		begin
			retrived_tweets = @client.search(keywords_space_separated, result_type: "mixed", geocode: geocode_str).take(99).collect
			retrived_tweets.each do |tweet| 
				num_attempts += 1
				@search.tweets << Tweet.new(twitters_tweet: tweet.to_hash)
				tweet_app = @search.tweets.last
				tweet_app.save
			end
		rescue Twitter::Error::TooManyRequests => error
			if num_attempts <= max_attempts
			# NOTE: Your process could go to sleep for up to 15 minutes but if you
			# retry any sooner, it will almost certainly fail with the same exception.
			    sleep error.rate_limit.reset_in
				retry
			else
				raise
			end
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
		  	start_search
		    format.js
		    # format.html { redirect_to @search, notice: 'Search was successfully executed.' }
		    # format.json { render :show, status: :created, location: @search }
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
		  params.permit(:search_type, :keywords, :latitude, :longitude, :radius, :depth_level, :data_stop, :time_stop, :ilimited)
		end
end
