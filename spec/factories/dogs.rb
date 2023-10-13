FactoryBot.define do
  factory :dog do
    user { nil }
    name { "MyString" }
    birthday { "2023-10-13" }
    sex { 1 }
    breed { "MyString" }
    profile_image { "MyString" }
  end
end
