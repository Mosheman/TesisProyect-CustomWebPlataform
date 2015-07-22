class Search
  include Mongoid::Document
  include Mongoid::Timestamps
  field :search_type, type: String
  field :keywords, type: String
  field :georeference, type: String
  field :depth_level, type: Integer
  field :data_stop, type: Integer, default: 1
  field :time_stop, type: Time
  field :ilimited, type: Boolean, default: true

  validates_numericality_of :data_stop, greater_than: 0

  belongs_to :user
  has_many :tweets
  has_many :twitter_users
end
