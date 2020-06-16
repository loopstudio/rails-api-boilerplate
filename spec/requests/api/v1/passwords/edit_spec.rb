require 'rails_helper'
require 'addressable/uri'

describe 'GET api/v1/users/password/edit', type: :request do
  subject(:get_request) do
    get edit_user_password_path, params: params, headers: headers, as: :json
  end

  let(:user) { create(:user) }

  let!(:password_token) { user.send(:set_reset_password_token) }

  context 'with a valid token' do
    let(:params) do
      {
        reset_password_token: password_token
      }
    end

    it 'returns a successful response' do
      get_request

      expect(response).to be_successful
    end
  end

  context 'with an expired token' do
    let(:params) do
      {
        reset_password_token: password_token
      }
    end

    before do
      sent_at = user.reset_password_sent_at - Devise.reset_password_within - 1.second
      user.update!(reset_password_sent_at: sent_at)
    end

    specify do
      get_request

      expect(response).to have_http_status(:bad_request)
    end

    it 'renders an error message explaining the code expired' do
      get_request

      expect(json[:errors]).to include(I18n.t('errors.messages.reset_password_token_expired'))
    end
  end

  context 'with an invalid token' do
    let(:params) do
      {
        reset_password_token: 'invalid token'
      }
    end

    specify do
      get_request

      expect(response).to have_http_status(:not_found)
    end
  end
end
