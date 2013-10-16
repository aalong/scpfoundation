Fabricator(:user) do
  username { Faker::Name.first_name * 2 }
  email { Faker::Internet.email }
  password { 'foobarfoobar' }
  password_confirmation { 'foobarfoobar' }
  properties { { real_name: Faker::Name.name } }
end

Fabricator(:member, from: :user) do
  reputation 500
end

Fabricator(:established_member, from: :user) do
  reputation 2000
end

Fabricator(:trusted_member, from: :user) do
  reputation 5000
end

Fabricator(:moderator, from: :user) do
  reputation 15000
end

Fabricator(:admin, from: :user) do
  reputation 30000
end
