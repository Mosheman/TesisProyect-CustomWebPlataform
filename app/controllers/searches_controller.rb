class SearchesController < ApplicationController
	before_action :set_search, only: [:show, :edit, :update, :destroy]

	# def search_enqueued
	# 	respond_to do |format|
	# 	    format.js
	# 	end
	# end

	

	# GET /searches
	# GET /searches.json
	def index
		@searches = current_user.searches.order("created_at DESC")
	end

	# GET /searches/1
	# GET /searches/1.json
	def show
	end

	def show_tweets
		@search = current_user.searches.find params[:search_id]
		@coords = Array.new
		@search.tweets.each do |app_tweet|
			if app_tweet.twitters_tweet[:geo]
				@coords << {"screen_name" => app_tweet.twitters_tweet[:user][:screen_name],
							"lat" => app_tweet.twitters_tweet[:geo][:coordinates][0],
							"lng" => app_tweet.twitters_tweet[:geo][:coordinates][1]}
			end
		end
	end

	def show_users
		@search = current_user.searches.find params[:search_id]
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
  		@search.start_search

		respond_to do |format|
		  if @search
		    format.js
		    # format.html { redirect_to @search, notice: 'Search was successfully executed.' }
		    # format.json { render :show, status: :created, location: @search }
		  else
		    format.html { render :new }
		    # format.json { render json: @search.errors, status: :unprocessable_entity }
		  end
		end
	end

	def create_quick
		current_user.searches << Search.new(search_params)
		@search = current_user.searches.last
  		@search.start_search

  		respond_to do |format|
	 	    format.js
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
		  params.permit(:search_type, :keywords, :latitude, :longitude, :radius, :depth_level, :data_stop, :time_stop, :ilimited, :result_type, :lang)
		end
end
