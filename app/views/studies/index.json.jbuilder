json.array!(@studies) do |study|
  json.extract! study, :id, :name, :description
  json.url study_url(study, format: :json)
end
