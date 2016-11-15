class Study
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :description, type: String
  field :data_type, type: String

  belongs_to :user
  has_many :packages
  has_many :markers
  has_many :nodes
end
