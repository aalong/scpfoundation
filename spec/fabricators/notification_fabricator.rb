Fabricator(:notification) do
  notification_type { :system }
  description { Faker::Lorem.sentence }
  user { Fabricate(:user) }
end
