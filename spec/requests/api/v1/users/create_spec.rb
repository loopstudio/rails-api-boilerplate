require 'rails_helper'

describe 'POST /api/v1/users', type: :request do
  subject(:post_request) do
    post api_v1_users_path, params: params, as: :json
  end

  let(:first_name) { 'Obi Wan' }
  let(:last_name) { 'Kenobi' }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let(:params) do
    {
      user: {
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password
      }
    }
  end

  context 'with correct params given' do
    let(:created_user) { User.last }

    specify do
      post_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns the user data' do
      post_request

      expect(json[:user]).to include_json(
        id: created_user.id,
        first_name: created_user.first_name,
        last_name: created_user.last_name,
        email: created_user.email
      )
    end

    it 'sets the authentication headers' do
      post_request

      token = response.header['access-token']
      client = response.header['client']

      expect(created_user.reload.valid_token?(token, client)).to be_truthy
    end
  end

  context 'with invalid params' do
    context 'when the email is missing' do
      let(:email) { nil }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post_request

        expect(json[:attributes_errors][:email]).not_to be_nil
      end
    end

    context 'when the password is missing' do
      let(:password) { nil }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post_request

        expect(json[:attributes_errors][:password]).not_to be_nil
      end
    end
  end
end
