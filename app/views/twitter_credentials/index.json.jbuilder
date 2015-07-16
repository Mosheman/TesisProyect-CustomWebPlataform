json.array!(@twitter_credentials) do |twitter_credential|
  json.extract! twitter_credential, :id, :consumer_key, :consumer_secret, :access_token, :access_token_secret, :user_id
  json.url twitter_credential_url(twitter_credential, format: :json)
end
