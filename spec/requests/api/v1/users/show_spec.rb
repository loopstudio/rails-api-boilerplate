require 'rails_helper'

describe 'GET /api/v1/users', type: :request do
  let(:user) { create(:user) }

  context 'being signed in' do
    subject(:get_request) do
      get api_v1_users_path(user.id), headers: auth_headers, as: :json
    end

    specify do
      get_request

      expect(response).to have_http_status(:success)
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
  end

  context 'not being signed in' do
    subject(:not_sign_in_request) do
      get api_v1_users_path(user.id), as: :json
    end

    include_examples 'not signed in examples'
  end
end
