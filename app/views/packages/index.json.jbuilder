json.array!(@packages) do |package|
  json.extract! package, :id, :data_type, :data
  json.url package_url(package, format: :json)
end
