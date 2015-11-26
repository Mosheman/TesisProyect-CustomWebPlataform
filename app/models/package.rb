class Package
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data_type, type: String
  field :transmitter, type: String

  belongs_to :user

  has_many :tweets
  has_many :twitter_users

  def data_count
  	get_tweets_count + get_tusers_count
  end

  def get_tweets_count
  	tweets.blank? ? 0 : tweets.count
  end

  def get_tusers_count
    twitter_users.blank? ? 0 : twitter_users.count
  end

  def set_data_type tweets_count, tusers_count
		
		if tweets_count>0 and tusers_count==0
			self.data_type = :tweets
		elsif tusers_count>0 and tweets_count==0
			self.data_type = :tusers
		elsif tusers_count>0 and tweets_count>0
			self.data_type = :mixed
		elsif tusers_count==0 and tweets_count==0
			self.data_type = :empty
		end
		self.save
	end

	def allocate_data search_ids
		tweets_count = 0
		tusers_count = 0
		searches = search_ids.blank? ? [] : user.searches.find(search_ids)
		searches.each do |search|
			if search.search_type == "tusers"
				twitter_users << search.twitter_users
				tusers_count += 1
			elsif search.search_type == "keywords"
				tweets << search.tweets
				tweets_count += 1
			end
		end
		set_data_type tweets_count, tusers_count
	end

end
