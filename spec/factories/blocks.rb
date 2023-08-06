FactoryBot.define do
  factory :block do
    index { 1 }
    name { "MyString" }
    length { 1 }
    status { "running" }
    commit
  end
end
