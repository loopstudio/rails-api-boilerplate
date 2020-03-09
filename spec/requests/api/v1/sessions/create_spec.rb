require 'rails_helper'

describe 'POST /api/v1/users/sign_in', type: :request do
  subject(:post_request) do
    post user_session_path, params: params, as: :json
  end

  let(:password) { 'password' }
  let(:user) do
    create(:user, password: password)
  end

  context 'with an existing email and password' do
    let(:params) do
      {
        user: {
          email: user.email,
          password: password
        }
      }
    end

    specify do
      post_request

      expect(response).to have_http_status(:success)
    end

    it 'returns the user data' do
      post_request

      expect(json[:user]).to include_json(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        locale: user.locale
      )
    end

    it 'returns if the user needs to change the password' do
      post_request

      expect(json[:must_change_password]).to eq(user.must_change_password)
    end

    it 'returns a valid client and access token' do
      post_request

      token = response.header['access-token']
      client = response.header['client']
      expect(user.reload.valid_token?(token, client)).to be_truthy
    end
  end

  context 'when the password is invalid for the given email' do
    let(:params) do
      {
        user: {
          email: user.email,
          password: 'wrong_password'
        }
      }
    end

    specify do
      post_request

      expect(response).to be_forbidden
    end
  end

  context 'when the email does not exist' do
    let(:params) do
      {
        user: {
          email: 'wrong@email.com',
          password: user.password
        }
      }
    end

    specify do
      post_request

      expect(response).to be_forbidden
    end
  end
end
