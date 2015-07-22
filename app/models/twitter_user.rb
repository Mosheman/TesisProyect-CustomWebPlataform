class TwitterUser
  include Mongoid::Document
  include Mongoid::Timestamps
  field :connections, type: Array
  field :description, type: String
  field :favourites_count, type: Integer
  field :followers_count, type: Integer
  field :friends_count, type: Integer
  field :lang, type: String
  field :listed_count, type: Integer
  field :location, type: String
  field :name, type: String
  field :profile_background_color, type: String
  field :profile_link_color, type: String
  field :profile_sidebar_border_color, type: String
  field :profile_sidebar_fill_color, type: String
  field :profile_text_color, type: String
  field :statuses_count, type: Integer
  field :time_zone, type: String
  field :utc_offset, type: Integer

  belongs_to :search
end
