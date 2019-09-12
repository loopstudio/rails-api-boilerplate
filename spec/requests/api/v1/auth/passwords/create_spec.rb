describe 'POST api/v1/auth/passwords', type: :request do

  subject do
    post api_v1_user_password_path, params: params, as: :json
    response
  end

  let(:user) { create(:user) }
  let(:params) { { email: user.email } }

  context 'when the user exists' do
    it { is_expected.to have_http_status(:no_content) }
  end

  context 'when the user does not exist' do
    let(:user) { build(:user) }

    it 'returns credentials not valid message' do
      expect(json(subject)).to eq(errors: [I18n.t('errors.authentication.invalid_credentials')])
    end
  end
end
