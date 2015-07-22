json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :favorite_count, :filter_level, :in_reply_to_screen_name, :in_reply_to_status_id, :in_reply_to_user_id, :lang, :retweet_count, :source, :text
  json.url tweet_url(tweet, format: :json)
end
