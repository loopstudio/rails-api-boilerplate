require 'rails_helper'
require 'addressable/uri'

describe 'PUT api/v1/users/password/', type: :request do
  subject(:put_request) do
    put user_password_path, params: params, headers: headers, as: :json
  end

  let(:user) { create(:user) }

  let!(:password_token) { user.send(:set_reset_password_token) }
  let(:new_password) { '123456789aA?!' }

  context 'with a valid token' do
    let(:params) do
      {
        reset_password_token: password_token,
        password: new_password
      }
    end

    context 'with valid params' do
      it 'returns a successful response' do
        put_request

        expect(response).to be_successful
      end

      it 'updates the user password' do
        expect {
          put_request
        }.to(change { user.reload.encrypted_password })
      end

      it 'makes the new password valid' do
        put_request

        expect(user.reload.valid_password?(new_password)).to eq(true)
      end

      it 'returns the user data' do
        put_request

        expect(json[:user]).to include_json(
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email
        )
      end

      it 'returns a valid client and access token' do
        put_request

        token = response.header['access-token']
        client = response.header['client']
        expect(user.reload.valid_token?(token, client)).to be_truthy
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          reset_password_token: password_token,
          password: nil
        }
      end

      specify do
        put_request

        expect(response).to have_http_status(:bad_request)
      end

      it 'does not change the user password' do
        expect {
          put_request
        }.to_not change(user.reload, :encrypted_password)
      end
    end
  end

  context 'with an invalid token' do
    let(:params) do
      {
        reset_password_token: 'invalid token',
        password: new_password
      }
    end

    specify do
      put_request

      expect(response).to have_http_status(:bad_request)
    end

    it 'does not change the user password' do
      expect {
        put_request
      }.to_not change(user.reload, :encrypted_password)
    end

    it 'does not make the new password valid' do
      put_request

      expect(user.reload.valid_password?(new_password)).to_not be
    end
  end
end
