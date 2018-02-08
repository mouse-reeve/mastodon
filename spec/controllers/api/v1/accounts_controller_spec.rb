require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  render_views

<<<<<<< HEAD
  let(:user)  { Fabricate(:user, account: Fabricate(:account, username: 'mus')) }
  let(:token) { double acceptable?: true, resource_owner_id: user.id }
=======
  let(:user)  { Fabricate(:user, account: Fabricate(:account, username: 'alice')) }
  let(:token) { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: 'follow read') }
>>>>>>> master

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #follow' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob', locked: locked)).account }

    before do
      post :follow, params: { id: other_account.id }
    end

<<<<<<< HEAD
  describe 'PATCH #update_credentials' do
    describe 'with valid data' do
      before do
        avatar = File.read(Rails.root.join('app', 'assets', 'images', 'logo.png'))
        header = File.read(Rails.root.join('app', 'assets', 'images', 'mastodon-getting-started.png'))

        patch :update_credentials, params: {
          display_name: "mus Isn't Dad",
          note: "Hi!\n\nToot toot!",
          avatar: "data:image/png;base64,#{Base64.encode64(avatar)}",
          header: "data:image/png;base64,#{Base64.encode64(header)}",
        }
      end
=======
    context 'with unlocked account' do
      let(:locked) { false }
>>>>>>> master

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

<<<<<<< HEAD
      it 'updates account info' do
        user.account.reload

        expect(user.account.display_name).to eq("mus Isn't Dad")
        expect(user.account.note).to eq("Hi!\n\nToot toot!")
        expect(user.account.avatar).to exist
        expect(user.account.header).to exist
      end
    end
=======
      it 'returns JSON with following=true and requested=false' do
        json = body_as_json
>>>>>>> master

        expect(json[:following]).to be true
        expect(json[:requested]).to be false
      end

      it 'creates a following relation between user and target user' do
        expect(user.account.following?(other_account)).to be true
      end
    end

    context 'with locked account' do
      let(:locked) { true }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns JSON with following=false and requested=true' do
        json = body_as_json

        expect(json[:following]).to be false
        expect(json[:requested]).to be true
      end

      it 'creates a follow request relation between user and target user' do
        expect(user.account.requested?(other_account)).to be true
      end
    end
  end

  describe 'POST #unfollow' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob')).account }

    before do
      user.account.follow!(other_account)
      post :unfollow, params: { id: other_account.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'removes the following relation between user and target user' do
      expect(user.account.following?(other_account)).to be false
    end
  end

  describe 'POST #block' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob')).account }

    before do
      user.account.follow!(other_account)
      post :block, params: { id: other_account.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'removes the following relation between user and target user' do
      expect(user.account.following?(other_account)).to be false
    end

    it 'creates a blocking relation' do
      expect(user.account.blocking?(other_account)).to be true
    end
  end

  describe 'POST #unblock' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob')).account }

    before do
      user.account.block!(other_account)
      post :unblock, params: { id: other_account.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'removes the blocking relation between user and target user' do
      expect(user.account.blocking?(other_account)).to be false
    end
  end

  describe 'POST #mute' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob')).account }

    before do
      user.account.follow!(other_account)
      post :mute, params: {id: other_account.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'does not remove the following relation between user and target user' do
      expect(user.account.following?(other_account)).to be true
    end

    it 'creates a muting relation' do
      expect(user.account.muting?(other_account)).to be true
    end

    it 'mutes notifications' do
      expect(user.account.muting_notifications?(other_account)).to be true
    end
  end

  describe 'POST #mute with notifications set to false' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob')).account }

    before do
      user.account.follow!(other_account)
      post :mute, params: {id: other_account.id, notifications: false }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'does not remove the following relation between user and target user' do
      expect(user.account.following?(other_account)).to be true
    end
<<<<<<< HEAD
  end

  describe 'GET #relationships' do
    let(:simon) { Fabricate(:user, email: 'simon@example.com', account: Fabricate(:account, username: 'simon')).account }
    let(:louis) { Fabricate(:user, email: 'louis@example.com', account: Fabricate(:account, username: 'louis')).account }

    before do
      user.account.follow!(simon)
      louis.follow!(user.account)
=======

    it 'creates a muting relation' do
      expect(user.account.muting?(other_account)).to be true
>>>>>>> master
    end

    it 'does not mute notifications' do
      expect(user.account.muting_notifications?(other_account)).to be false
    end
  end

  describe 'POST #unmute' do
    let(:other_account) { Fabricate(:user, email: 'bob@example.com', account: Fabricate(:account, username: 'bob')).account }

    before do
      user.account.mute!(other_account)
      post :unmute, params: { id: other_account.id }
    end

<<<<<<< HEAD
    context 'provided multiple IDs' do
      before do
        get :relationships, params: { id: [simon.id, louis.id] }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
=======
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
>>>>>>> master

    it 'removes the muting relation between user and target user' do
      expect(user.account.muting?(other_account)).to be false
    end
  end
end
