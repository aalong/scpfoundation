json.array!(@messages) do |message|
  json.extract! message, :content, :type, :user_id, :room_id
  json.url message_url(message, format: :json)
end
