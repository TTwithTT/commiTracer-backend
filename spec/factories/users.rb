# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { 'MyString' }
    sequence(:uid) { |n| "UID#{n}" }
    name { 'John Doe' }
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end
