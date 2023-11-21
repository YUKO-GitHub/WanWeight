FactoryBot.define do
  factory :diary do
    user { nil }
    dog { nil }
    date { "2023-11-15 13:14:39" }
    diary_text { "MyText" }
    meal_text { "MyText" }
    exercise_text { "MyText" }
    health_text { "MyText" }
  end
end
