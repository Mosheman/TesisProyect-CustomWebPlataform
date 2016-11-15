class TwitterRequest 
	include Mongoid::Document
	include Mongoid::Timestamps

	field :calls, type: Integer

	belongs_to :search
	belongs_to :twitter_credential

	def get_time_last_request opts={}

	end
end
