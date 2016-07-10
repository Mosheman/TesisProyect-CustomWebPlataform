class Marker
  include Mongoid::Document

  field :owner, type: String
  field :owner_id, type: String
  field :text, type: String
  field :lat, type: String
  field :lng, type: String
  field :tweet_id, type: String
  field :inner_tweet_id, type: String
  field :infowindow, type: String
  field :picture, type: Hash, default: {
                                          "url": "/assets/comment.png",
                                          "width":  32,
                                          "height": 32
                                        }

  belongs_to :study
  belongs_to :package
  embedded_in :custom_date
end
