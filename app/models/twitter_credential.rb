class TwitterCredential 
	include Mongoid::Document

	field :consumer_key, type: String
	field :consumer_secret, type: String
	field :access_token, type: String
	field :access_token_secret, type: String

	validates :consumer_key, presence: true
	validates :consumer_secret, presence: true

	embedded_in :user
end
