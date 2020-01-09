describe 'DELETE api/v1/auth/registrations', type: :request do
  subject(:delete_request) do
    delete api_v1_user_registration_path, headers: headers, as: :json
  end

  let(:user) { create(:user) }

  include_examples 'not signed in examples'

  context 'when the user is signed in' do
    let(:headers) { auth_headers(user) }

    specify do
      delete_request

      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the user record' do
      delete api_v1_user_registration_path, headers: headers, as: :json
      expect(User.find_by(email: user.email)).to be_nil
    end
  end
end
