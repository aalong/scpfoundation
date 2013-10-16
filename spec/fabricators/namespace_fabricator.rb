Fabricator(:namespace) do
  title { Faker::Lorem.word }
  name { Faker::Lorem.word }
  user { User.find_by_username('community') }
  access { 'community' }
end

Fabricator(:public_namespace, from: :namespace) do
  access { 'public' }
end

Fabricator(:private_namespace, from: :namespace) do
  access { 'private' }
end
