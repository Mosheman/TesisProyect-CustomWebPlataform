class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :twitters_tweet, type: Hash
  # field :favorite_count, type: Integer
  # field :filter_level, type: String
  # field :in_reply_to_screen_name, type: String
  # field :in_reply_to_status_id, type: Integer
  # field :in_reply_to_user_id, type: Integer
  # field :lang, type: String
  # field :retweet_count, type: Integer
  # field :source, type: String
  # field :text, type: String

  belongs_to :search
  belongs_to :package

  def get_alternative_geo
    self.twitters_tweet[:place] ? self.twitters_tweet[:place][:bounding_box][:coordinates].first.first : nil
  end

  def get_latitude
    self.twitters_tweet[:geo] ? self.twitters_tweet[:geo][:coordinates][0] : self.get_alternative_geo[1]
  end

  def get_longitude
    self.twitters_tweet[:geo] ? self.twitters_tweet[:geo][:coordinates][1] : self.get_alternative_geo[0]
  end
end
