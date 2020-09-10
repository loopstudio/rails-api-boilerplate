require 'rails_helper'

describe 'DELETE /api/v1/users/sign_out', type: :request do
  let(:user) { create(:user) }

  context 'when being signed in' do
    subject(:delete_request) do
      delete destroy_user_session_path, headers: auth_headers, as: :json
    end

    let(:access_token) { auth_headers['access-token'] }
    let(:client) { auth_headers['client'] }

    specify do
      delete_request

      expect(response).to have_http_status(:success)
    end

    it 'destroys the user token' do
      expect {
        delete_request
      }.to change { user.reload.valid_token?(access_token, client) }.from(true).to(false)
    end
  end

  context 'when not being signed in' do
    subject(:not_signed_in_request) do
      delete destroy_user_session_path, as: :json
    end

    specify do
      not_signed_in_request

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
