FactoryBot.define do
  factory :dog do
    association :user
    name { "レオ" }
    birthday { "2020-01-01" }
    sex { "male" }
  end
end
