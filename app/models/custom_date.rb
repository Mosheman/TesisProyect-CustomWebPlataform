class CustomDate
	include Mongoid::Document

	field :day, type: Integer
	field :month, type: Integer

	embedded_in :custom_year
	embeds_many :markers
end