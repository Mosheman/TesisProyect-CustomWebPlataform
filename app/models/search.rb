class Search
  include Mongoid::Document
  include Mongoid::Timestamps

  field :keywords, type: String
  field :lang, type: String
  # => Georeference
  field :latitude, type: String
  field :longitude, type: String
  field :radius, type: String
  # => May be tweets search, or user search
  field :search_type, type: String
  #field :search_lvl, type: Integer
  # => May be "recent", "popular" or "mixed"
  field :result_type, type: String
  # => If search_type is user
  field :depth_level, type: Integer
  # => Stop criteria
  field :data_stop, type: Integer, default: 180
  field :time_stop, type: Time
  field :ilimited, type: Boolean, default: true
  # => status
  field :status, type: String

  # => Callbacks
  after_create :dispatch_search

  # => Validations
  validates_numericality_of :data_stop, greater_than: 0

  # => Relations
  belongs_to :user
  belongs_to :queue
  has_many :tweets
  has_many :twitter_users
  has_many :twitter_requests

  embeds_many :jobs

  def dispatch_search
    if user.has_pending_queue_searches
      self.status = :waiting
      enqueue
    else
      self.status = :processing
    end
  end

  def enqueue
    user.queue.searches << self
    start_async
  end

  def start_async
    space_separated_words
    if search_type == "keywords"
      # => Call to Async Worker for Tweet Search
      TweetSearchWorker.perform_async id
    elsif search_type == "tusers"
      # => Call to Async Worker for Twitter Users Search
      TuserSearchWorker.perform_async id
    end
  end

  def space_separated_words
    # Replaces all blanks+ and end of lines, for single-space.
    keywords = keywords ? keywords.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '') : nil
  end

  def get_geocode
    # => Parser geocode from coords & radius
    geocode = latitude.to_s + "," + longitude.to_s + "," + radius.to_s + "km"
    geocode
  end

  def has_data
    ( (self.twitter_users.count > 0) || (self.tweets.count > 0) )
  end

  def get_calls
    calls_count = get_tweets_count + get_tusers_count

    if jobs.blank?
      calls_count
    else
      jobs.each do |job|
        calls_count += job.calls
      end
    end
  end

  def get_tweets_count
    tweets.blank? ? 0 : tweets.count
  end

  def get_tusers_count
    twitter_users.blank? ? 0 : twitter_users.count
  end

  def start_search
    if self.status == "processing"
      self.instant_search
    elsif self.status == "waiting"
      self.search_enqueued
    end
  end

  def instant_search
    if self.search_type == "keywords"
      geocode = self.get_geocode
      search_keywords self.keywords, geocode
    elsif self.search_type == "tusers"
      keywords_array = self.keywords ? self.keywords.split(" ") : []
      tuser_query = keywords_array.first
      search_tusers tuser_query, self.result_type
    end
  end

  def search_keywords query, georeference
    # => Getting rate limits status
    max_attempts = 3
    num_attempts = 0
    begin
      num_attempts += 1
      tweets_retrived = self.user.get_twitter_client.search(query, result_type: self.result_type, geocode: georeference).take(180).collect
      tweets_retrived.each do |tweet|
        self.tweets << Tweet.new(twitters_tweet: tweet.to_hash)
      end
      self.user.twitter_credential.set_request(self.id) if self.user.twitter_credential
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

  def search_tusers tuser_query, query_type
    # => Getting rate limits status
    max_attempts = 3
    num_attempts = 0
    begin
      num_attempts += 1
      if query_type == "following"
        tusers_retrived = self.user.get_twitter_client.friends tuser_query
        tusers_retrived.each do |tuser|
          self.twitter_users << TwitterUser.new(twitters_user: tuser.to_hash)
        end
      elsif query_type == "followers"
        tusers_retrived = self.user.get_twitter_client.followers tuser_query
        tusers_retrived.each do |tuser|
          self.twitter_users << TwitterUser.new(twitters_user: tuser.to_hash)
        end
      end
      self.user.twitter_credential.set_request self.id
    rescue Twitter::Error => error
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

end
