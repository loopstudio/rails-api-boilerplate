require 'rails_helper'

describe 'PUT /api/v1/users', type: :request do
  let(:user) { create(:user) }

  let(:params) do
    {
      user:
      {
        first_name: first_name,
        last_name: last_name
      }
    }
  end

  let(:first_name) { 'Darth' }
  let(:last_name) { 'Vader' }

  context 'being signed in' do
    subject(:put_request) do
      put api_v1_users_path, params: params, headers: auth_headers, as: :json
    end

    context 'with valid params' do
      specify do
        put_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the user data' do
        put_request

        user.reload
        expect(json[:user]).to include_json(
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email
        )
      end
    end
  end

  context 'not being signed in' do
    subject(:not_signed_in_request) do
      put api_v1_users_path, params: params, as: :json
    end

    include_examples 'not signed in examples'
  end
end
