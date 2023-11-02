FactoryBot.define do
  factory :user_weight do
    weight { rand(50..100).to_f }
    date { Faker::Date.between(from: Date.current.beginning_of_month, to: Date.current.end_of_month) }
    association :user
  end
end
