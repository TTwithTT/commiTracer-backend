require 'rails_helper'

RSpec.describe "Api::V1::Commits", type: :request do
  let(:user) { create(:user) }
  let!(:commit) { create(:commit, user: user) }

  describe "GET /index" do
    let!(:commits) { create_list(:commit, 10, user: user) }

    it "returns the last 8 commits for the user" do
      get api_v1_user_commits_path(user.uid)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(8)
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      {
        title: "Test Commit",
        blocks_attributes: [
          { name: "Block1", length: 1, status: "onqueue" }
        ]
      }
    end

    it "creates a new commit for the user" do
      expect {
        post api_v1_user_commits_path(user.uid), params: { commit: valid_params }
      }.to change(Commit, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /update" do
    let(:updated_params) do
      {
        title: "Updated Commit",
        blocks_attributes: [
          { name: "Block2", length: 2, status: "done" }
        ]
      }
    end

    it "updates the commit" do
      put api_v1_user_commit_path(user.uid, commit), params: { commit: updated_params }
      expect(response).to have_http_status(:ok)
      commit.reload
      expect(commit.title).to eq("Updated Commit")
    end
  end

  describe "DELETE /destroy" do
    it "deletes the commit" do
      expect {
        delete api_v1_user_commit_path(user_id: user.uid, id: commit.id)
      }.to change(Commit, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
