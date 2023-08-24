# frozen_string_literal: true

FactoryBot.define do
  factory :commit do
    title { 'MyString' }
    user
  end
end
