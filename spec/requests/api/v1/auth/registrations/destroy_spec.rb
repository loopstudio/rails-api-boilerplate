describe 'DELETE api/v1/auth/registrations', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  subject do
    delete api_v1_user_registration_path, headers: headers, as: :json
    response
  end

  context 'when credentials given' do
    it { is_expected.to have_http_status(:no_content) }

    it 'deletes user account' do
      delete api_v1_user_registration_path, headers: headers, as: :json
      expect(User.find_by(email: user.email)).to eq nil
    end
  end

  context 'when no credentials given' do
    let(:headers) {}

    it { is_expected.to have_http_status(:forbidden) }

    it 'returns authentication required error' do
      expect(json_response(subject)).to eq(
        error: 'Authentication is required to perform this action'
      )
    end
  end
end
