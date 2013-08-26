Fabricator(:message) do
  content { Faker::Lorem.sentence }
  message_type { 'message' } 
  user { Fabricate(:user) }
  room { Fabricate(:room) }
end
