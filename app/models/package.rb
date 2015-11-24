class Package
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data_type, type: String

  belongs_to :user

  has_many :tweets
  has_many :twitter_users
end
