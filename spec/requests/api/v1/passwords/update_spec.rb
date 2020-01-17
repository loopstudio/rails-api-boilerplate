require 'rails_helper'

describe 'PUT /api/v1/users/password', type: :request do
  context 'being signed in' do
    subject(:put_request) do
      put user_password_path, params: params, headers: auth_headers, as: :json
    end

    let(:user) { create(:user, must_change_password: true, password: 'password') }
    let(:params) { { password: new_password } }

    context 'with valid params' do
      let(:new_password) { 'abcd1234' }

      specify do
        put_request

        expect(response).to have_http_status(:no_content)
      end

      it 'updates the user password' do
        put_request

        expect(user.reload.valid_password?('password')).to eq(false)
        expect(user.valid_password?(new_password)).to eq(true)
      end

      it 'updates the user must_change_password flag' do
        put_request

        expect(user.reload.must_change_password).to eq(false)
      end
    end
  end

  context 'not being signed in' do
    subject(:put_request) do
      put user_password_path, as: :json
    end

    include_examples 'not signed in examples'
  end
end
