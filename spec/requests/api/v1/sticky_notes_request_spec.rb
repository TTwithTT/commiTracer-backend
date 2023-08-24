# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::StickyNotes', type: :request do
  let(:user) { create(:user) }
  let(:commit) { create(:commit, user:) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'successfully creates a new sticky note' do
        expect(commit.sticky_notes.count).to eq(0)

        expect do
          post api_v1_user_commit_sticky_notes_path(user_id: user.uid, commit_id: commit.id),
               params: { sticky_note: { reflection: 'Test Reflection' } }
        end.to change(StickyNote, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:sticky_note) { create(:sticky_note, commit:) }

    context 'when the sticky note exists' do
      it 'successfully deletes the sticky note' do
        expect do
          delete api_v1_user_commit_sticky_note_path(user_id: user.uid, commit_id: commit.id, id: sticky_note.id)
        end.to change(StickyNote, :count).by(-1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('SUCCESS')
      end
    end

    context "when the sticky note doesn't exist" do
      it 'returns a not found error' do
        expect do
          delete api_v1_user_commit_sticky_note_path(user_id: user.id, commit_id: commit.id, id: 0)
        end.not_to change(StickyNote, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
