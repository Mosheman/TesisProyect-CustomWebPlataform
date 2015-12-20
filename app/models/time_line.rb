class TimeLine
	include Mongoid::Document

	field :day, type: Integer
	field :month, type: Integer

	embedded_in :studies
end