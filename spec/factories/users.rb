FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    birthday { 20.years.ago }
    height { rand(150.0..200.0).round(1) }
    email { Faker::Internet.email }
    password { 'password123' }
    introduction { Faker::Lorem.sentence }
  end
end
