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
    result = user.queue ? user.queue.count > 0 : false
  end

  def enqueue
    user.queue.searches << self  
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
end
