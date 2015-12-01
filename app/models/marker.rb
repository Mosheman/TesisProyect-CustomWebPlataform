class Marker
  include Mongoid::Document
  field :owner, type: String
  field :owner_id, type: String
  field :text, type: String
  field :lat, type: String
  field :lng, type: String
  field :tweet_id, type: String
  field :inner_tweet_id, type: String

  belongs_to :study
  belongs_to :package
end
