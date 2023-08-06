require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /create" do
    let(:valid_params) do
      {
        provider: "test_provider",
        userId: "test_user_id",
        name: "Test User",
        email: "test@example.com"
      }
    end

    context "with valid parameters" do
      it "creates a new user or finds an existing one" do
        expect {
          post "/api/v1/users", params: valid_params
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /exist" do
    let!(:user) { create(:user, uid: "test_user_id") }

    context "when user exists" do
      it "returns true" do
        get "/api/v1/users/exist", params: { id: user.uid }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["exists"]).to eq(true)
      end
    end

    context "when user doesn't exist" do
      it "returns false" do
        get "/api/v1/users/exist", params: { id: "nonexistent_uid" }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["exists"]).to eq(false)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:user) { create(:user, uid: "test_user_id") }

    context "when user exists" do
      it "deletes the user" do
        expect {
          delete "/api/v1/users/destroy", params: { id: user.uid }
        }.to change(User, :count).by(-1)
        expect(response).to have_http_status(:success)
      end
    end

    context "when user doesn't exist" do
      it "returns not found" do
        delete "/api/v1/users/destroy", params: { id: "nonexistent_uid" }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
