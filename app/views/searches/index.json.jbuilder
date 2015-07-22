json.array!(@searches) do |search|
  json.extract! search, :id, :search_type, :keywords, :georeference, :depth_level
  json.url search_url(search, format: :json)
end
