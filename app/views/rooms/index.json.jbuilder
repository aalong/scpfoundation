json.array!(@rooms) do |room|
  json.extract! room, :title, :description, :topic, :access
  json.url room_url(room, format: :json)
end
