require 'rails_helper'

RSpec.describe StickyNote, type: :model do
  it { should belong_to(:commit) }
end
