require 'rails_helper'

RSpec.describe Commit, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:blocks).dependent(:destroy) }
  it { should accept_nested_attributes_for(:blocks) }
  it { should have_many(:sticky_notes).dependent(:destroy) }
  
  describe 'validations' do
    let(:commit) { build(:commit) } 

    context 'when there are more than 3 sticky notes' do
      before do
        4.times { commit.sticky_notes.build }
      end

      it 'is not valid' do
        expect(commit.valid?).to be false
        expect(commit.errors[:sticky_notes]).to include("You can only have 3 sticky notes per commit.")
      end
    end
  end
end
