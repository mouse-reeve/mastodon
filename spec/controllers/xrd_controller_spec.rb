require 'rails_helper'

RSpec.describe XrdController, type: :controller do
  render_views

  describe 'GET #host_meta' do
    it 'returns http success' do
      get :host_meta
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #webfinger' do
    let(:mus) { Fabricate(:account, username: 'mus') }

    it 'returns http success when account can be found' do
      get :webfinger, params: { resource: mus.to_webfinger_s }, format: :json
      expect(response).to have_http_status(:success)
    end

    it 'returns http not found when account cannot be found' do
      get :webfinger, params: { resource: 'acct:not@existing.com' }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
