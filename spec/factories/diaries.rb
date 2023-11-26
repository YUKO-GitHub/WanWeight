FactoryBot.define do
  factory :diary do
    association :user
    dog { nil }
    date { Date.current }
    diary_text { Faker::Lorem.paragraph }
    meal_text { Faker::Lorem.paragraph }
    exercise_text { Faker::Lorem.paragraph }
    health_text { Faker::Lorem.paragraph }
  end
end
