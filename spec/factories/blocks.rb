FactoryBot.define do
  factory :block do
    name { "MyString" }
    length { 1 }
    status { "running" }
    commit
  end
end
