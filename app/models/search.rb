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
  field :search_lvl, type: Integer
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
    if has_pending_queue_searches
      self.status = :waiting
      enqueue
    else
      self.status = :processing
    end
  end

  def has_pending_queue_searches
    user.queue ? (user.queue.count) > 0 : false
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
    ( !twitter_users.blank? or !tweets.blank? ) 
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
end
