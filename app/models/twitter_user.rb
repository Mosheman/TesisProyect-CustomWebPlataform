class TwitterUser
  include Mongoid::Document
  include Mongoid::Timestamps

  field :twitters_user, type: Hash

  belongs_to :search
  belongs_to :package

  def get_from_twitter opts={}

  end

  def get_from_twitter_async opts={}

  end
end
