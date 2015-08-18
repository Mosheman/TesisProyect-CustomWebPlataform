class TwitterUser
  include Mongoid::Document
  include Mongoid::Timestamps

  field :twitters_user, type: Hash
  
  belongs_to :search
end
