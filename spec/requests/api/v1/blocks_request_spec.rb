require 'rails_helper'

RSpec.describe "Api::V1::Blocks", type: :request do
  let!(:block) { create(:block) }

  describe "DELETE /destroy" do
    context "when the block exists" do
      it "deletes the block" do
        expect {
          delete api_v1_block_path(block)
        }.to change(Block, :count).by(-1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["status"]).to eq('SUCCESS')
      end
    end

    context "when the block doesn't exist" do
      it "returns not found error" do
        expect {
          delete api_v1_block_path(0)
        }.not_to change(Block, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
