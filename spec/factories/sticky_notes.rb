FactoryBot.define do
  factory :sticky_note do
    reflection { "MyString" }
    commit_id { 1 }
  end
end
