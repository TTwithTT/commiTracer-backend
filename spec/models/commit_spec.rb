require 'rails_helper'

RSpec.describe Commit, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:blocks) }
  it { should accept_nested_attributes_for(:blocks) }
end
