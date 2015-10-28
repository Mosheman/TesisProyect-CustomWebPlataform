class Queue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Integer
  field :progress, type: String
  
  embedded_in :user

  has_many :searches
end
