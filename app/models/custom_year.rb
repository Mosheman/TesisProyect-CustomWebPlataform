class CustomYear
	include Mongoid::Document

	field :number, type: Integer

	embedded_in :time_line
	embeds_many :custom_dates
end