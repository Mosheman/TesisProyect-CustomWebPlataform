class Search
  include Mongoid::Document
  include Mongoid::Timestamps
  field :keywords, type: String
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

  validates_numericality_of :data_stop, greater_than: 0

  belongs_to :user
  has_many :tweets
  has_many :twitter_users
end
