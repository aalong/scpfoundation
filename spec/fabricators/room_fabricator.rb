Fabricator(:room) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
  topic { Faker::Lorem.sentence }
  access { 'public' }
end

Fabricator(:community_room, from: :room) do
  access { 'community' }
end

Fabricator(:private_room, from: :room) do
  access { 'private' }
end
