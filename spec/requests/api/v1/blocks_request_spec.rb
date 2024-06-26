# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Blocks', type: :request do
  let(:user) { create(:user) }
  let(:commit) { create(:commit, user:) }
  let!(:block) { create(:block, commit:) }

  describe 'DELETE /destroy' do
    context 'when the block exists' do
      it 'deletes the block' do
        expect do
          delete api_v1_user_commit_block_path(user_id: user.id, commit_id: commit.id, id: block.id)
        end.to change(Block, :count).by(-1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      end
    end

    context "when the block doesn't exist" do
      it 'returns not found error' do
        expect do
          delete api_v1_user_commit_block_path(user_id: user.id, commit_id: commit.id, id: 0)
        end.not_to change(Block, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
