# frozen_string_literal: true

FactoryBot.define do
  factory :block do
    name { 'MyString' }
    length { 1 }
    status { 'running' }
    commit
  end
end
