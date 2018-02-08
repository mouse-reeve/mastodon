require 'rails_helper'

RSpec.describe Api::V1::MutesController, type: :controller do
  render_views

<<<<<<< HEAD
  let(:user)  { Fabricate(:user, account: Fabricate(:account, username: 'mus')) }
  let(:token) { double acceptable?: true, resource_owner_id: user.id }
=======
  let(:user)  { Fabricate(:user, account: Fabricate(:account, username: 'alice')) }
  let(:token) { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: 'follow') }
>>>>>>> master

  before do
    Fabricate(:mute, account: user.account, hide_notifications: false)
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { limit: 1 }

      expect(response).to have_http_status(:success)
    end
  end
end
