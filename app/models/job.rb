class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :status, type: String
  field :progress, type: String
  
  embedded_in :search
end
