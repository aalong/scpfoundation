Fabricator(:page) do
  title { Faker::Lorem.word + ' ' + Faker::Lorem.word }
  name { Faker::Lorem.word }
  content { Faker::Lorem.sentence }
  user { Fabricate(:member) }
  namespace { Fabricate(:namespace) }
end
