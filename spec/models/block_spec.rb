# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Block, type: :model do
  it { should belong_to(:commit) }

  it 'should define enum for status' do
    should define_enum_for(:status)
      .with_values(onqueue: 0, running: 1, done: 2)
  end
end
