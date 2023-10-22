FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    birthday { 20.years.ago }
    email { Faker::Internet.email }
    password { 'password123' }
    introduction { Faker::Lorem.sentence }
  end
end
