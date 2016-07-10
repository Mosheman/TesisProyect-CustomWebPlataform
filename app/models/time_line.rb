class TimeLine
	include Mongoid::Document

	field :day, type: Integer
	field :month, type: Integer

	embedded_in :study
	embeds_many :custom_years
	has_many :packages
end