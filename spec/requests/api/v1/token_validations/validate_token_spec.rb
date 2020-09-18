require 'rails_helper'

describe 'GET /api/v1/users/validate_token', type: :request do
  let(:user) { create(:user) }

  context 'when being signed in' do
    subject(:get_request) do
      get api_v1_users_validate_token_path, headers: auth_headers, as: :json
    end

    specify do
      get_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns the user data' do
      get_request

      expect(json[:user]).to include_json(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        locale: user.locale
      )
    end

    it 'returns valid authentication headers' do
      get_request

      token = response.header['access-token']
      client = response.header['client']

      expect(user.reload).to be_valid_token(token, client)
    end
  end

  context 'when not being signed in' do
    subject(:not_signed_in_request) do
      get api_v1_users_validate_token_path, as: :json
    end

    it 'returns invalid token error' do
      not_signed_in_request

      expect(json[:errors]).to include(I18n.t('errors.authentication.invalid_token'))
    end
  end
end
