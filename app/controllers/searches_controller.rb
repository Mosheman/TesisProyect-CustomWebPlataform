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
	# def get_following user_query
	# 	tusers_retrived = @client.friends user_query
	# 	tusers_retrived.each do |tuser|
	# 		@num_attempts += 1
	# 		@search.twitter_users << TwitterUser.new(twitters_user: tuser.to_hash)
	# 	end
	# end
	# def get_followers user_query
	# 	tusers_retrived = @client.followers user_query
	# 	tusers_retrived.each do |tuser|
	# 		@num_attempts += 1
	# 		@search.twitter_users << TwitterUser.new(twitters_user: tuser.to_hash)
	# 	end
	# end
	# def get_keywords query, georeference
	# 	tweets_retrived = @client.search(query, result_type: @search.result_type, geocode: georeference).take(99).collect
	# 	tweets_retrived.each do |tweet| 
	# 		@num_attempts += 1
	# 		@search.tweets << Tweet.new(twitters_tweet: tweet.to_hash)
	# 	end		
	# end
	def start_search
		# => Params raw
		keywords_raw = @search.keywords
		latitude_raw = @search.latitude
		longitude_raw = @search.longitude
		radius_raw = @search.radius

		keywords_query = String.new
		tuser_query = String.new
		geocode = String.new

		# => Getting credentials
		@client = get_client_credentials

		if @search.search_type == "keywords"			
			# => Parser keywords
			# Replaces all blanks+ and end of lines, for single-space. 
			keywords_query = keywords_raw.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '')
			# keywords_array = keywords_space_separated.split(" ")
			# # String <- Coma separated keywords
			# keywords_str = keywords_array.join(",")

			# => Parser geocode
			geocode = latitude_raw.to_s + "," + longitude_raw.to_s + "," + radius_raw.to_s + "km"
			
			search_keywords keywords_query, geocode
		elsif @search.search_type == "tusers"
			# => Parser tuser
			# Replaces all blanks+ and end of lines, for single-space. 
			keywords_space_separated = keywords_raw.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '')
			keywords_array = keywords_space_separated.split(" ")

			tuser_query = keywords_array.first 
			
			search_tusers tuser_query, @search.result_type
		end		
	end

	def search_keywords query, georeference
		# => Getting rate limits status
		@max_attempts = 180
		@num_attempts = 0
		begin
			tweets_retrived = @client.search(query, result_type: @search.result_type, geocode: georeference).take(180).collect
			tweets_retrived.each do |tweet| 
				@num_attempts += 1
				@search.tweets << Tweet.new(twitters_tweet: tweet.to_hash)
			end	
		rescue Twitter::Error::TooManyRequests => error
			if @num_attempts <= @max_attempts
			# NOTE: Your process could go to sleep for up to 15 minutes but if you
			# retry any sooner, it will almost certainly fail with the same exception.
			    sleep error.rate_limit.reset_in
				retry
			else
				raise
			end
		end
	end

	def search_tusers tuser_query, query_type
		# => Getting rate limits status
		@max_attempts = 180
		@num_attempts = 0
		begin
			if query_type == "following"
				tusers_retrived = @client.friends tuser_query
				tusers_retrived.each do |tuser|
					@num_attempts += 1
					@search.twitter_users << TwitterUser.new(twitters_user: tuser.to_hash)
				end
			elsif query_type == "followers"
				tusers_retrived = @client.followers tuser_query
				tusers_retrived.each do |tuser|
					@num_attempts += 1
					@search.twitter_users << TwitterUser.new(twitters_user: tuser.to_hash)
				end
			end
		rescue Twitter::Error::TooManyRequests => error
			if @num_attempts <= @max_attempts
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
	end

	# GET /searches/1
	# GET /searches/1.json
	def show
	end

	def show_tweets
		@search = Search.find params[:search_id]
		@coords = Array.new
		@search.tweets.each do |app_tweet|
			@coords << {"screen_name" => app_tweet.twitters_tweet[:user][:screen_name],
						"lat" => app_tweet.twitters_tweet[:geo][:coordinates][0], 
						"lng" => app_tweet.twitters_tweet[:geo][:coordinates][1]} 
		end
	end

	def show_users
		@search = Search.find params[:search_id]
	end

	def set_searchtype 
		
		stype = params[:search_type]
		@searchtype_selected = SearchType.new stype[:label], true, stype[:path_name], stype[:name] 

		respond_to do |format|
		    format.js
		end
	end

	# GET /searches/new
	def new
		n_calls = rate_limit_status	
		@n_calls = 180

		st_one = SearchType.new("Palabras clave", true, "keywords_searches", "keywords")
		st_two = SearchType.new("Usuarios", false, "tusers_searches", "tusers")
		@search_types = [st_one, st_two]
		@searchtype_selected = st_one
		set_params_searchtype st_one.get_attributes
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
		  if @search
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
		if @search.search_type == "keywords"
			@search.tweets.each do |t|
				t.destroy
			end
		elsif @search.search_type == "tusers"
			@search.twitter_users.each do |t|
				t.destroy
			end
		end
		@search.destroy
		respond_to do |format|
		  format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
		  format.json { head :no_content }
		end
	end

	def set_params_searchtype search_type
		params = ActionController::Parameters.new(search_type: search_type)
	end

	private
	# Use callbacks to share common setup or constraints between actions.
		def set_search
		  @search = current_user.searches.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def search_params
		  params.permit(:search_type, :keywords, :latitude, :longitude, :radius, :depth_level, :data_stop, :time_stop, :ilimited, :result_type)
		end
end
