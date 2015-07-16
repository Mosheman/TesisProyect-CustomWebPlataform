class TwitterCredential < ActiveRecord::Base
  belongs_to :user

  validates :consumer_key, presence: true
  validates :consumer_secret, presence: true
end
