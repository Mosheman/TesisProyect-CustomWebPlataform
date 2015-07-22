json.array!(@twitter_users) do |twitter_user|
  json.extract! twitter_user, :id, :connections, :description, :favourites_count, :followers_count, :friends_count, :lang, :listed_count, :location, :name, :profile_background_color, :profile_link_color, :profile_sidebar_border_color, :profile_sidebar_fill_color, :profile_text_color, :statuses_count, :time_zone, :utc_offset
  json.url twitter_user_url(twitter_user, format: :json)
end
