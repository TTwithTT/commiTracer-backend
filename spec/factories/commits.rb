FactoryBot.define do
  factory :commit do
    title { "MyString" }
    scheduledDate { "2023-06-13 07:43:20" }
    user
  end
end
