# frozen_string_literal: true

FactoryBot.define do
  factory :sticky_note do
    reflection { 'MyString' }
    commit
  end
end
