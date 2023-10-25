FactoryBot.define do
  factory :dog do
    association :user
    sequence(:name) { |n| "レオ#{n}" }
    birthday { "2020-01-01" }
    sex { [:unselected, :female, :male].sample }
    breed { "シバイヌ" }
  end
end
