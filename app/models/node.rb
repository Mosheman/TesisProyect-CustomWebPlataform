class Node
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :tuser_id, type: String
  field :inner_tuser_id, type: String
  field :infowindow, type: String
  field :created_at, type: DateTime
  field :points_to, type: Hash

  belongs_to :study
  belongs_to :package
  embedded_in :custom_date
end
