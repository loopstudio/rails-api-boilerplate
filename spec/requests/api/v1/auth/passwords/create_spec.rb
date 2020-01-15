describe 'POST api/v1/auth/passwords', type: :request do
  subject(:post_request) do
    post api_v1_user_password_path, params: params, as: :json
  end

  let(:user) { create(:user) }
  let(:params) { { email: user.email } }

  context 'when the user exists' do
    specify do
      post_request

      expect(response).to have_http_status(:no_content)
    end
  end

  context 'when the user does not exist' do
    let(:user) { build(:user) }

    it 'returns credentials not valid message' do
      post_request

      expect(json[:errors]).to include(I18n.t('errors.authentication.invalid_credentials'))
    end
  end
end
