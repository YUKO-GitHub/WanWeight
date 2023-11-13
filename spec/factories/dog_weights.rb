FactoryBot.define do
  factory :dog_weight do
    weight { rand(5.0..50.0).round(1) }
    date { Faker::Date.between(from: Date.current.beginning_of_month, to: Date.current.end_of_month) }
    association :dog
  end
end
