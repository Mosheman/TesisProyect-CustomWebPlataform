class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :status, type: Integer
  field :calls, type: Integer
  field :progress, type: String

  embedded_in :search

  def get_failed opt={}
  end
end
