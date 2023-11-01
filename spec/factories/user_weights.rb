FactoryBot.define do
  factory :user_weight do
    weight { rand(50..100).to_f }
    date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    association :user
  end
end
