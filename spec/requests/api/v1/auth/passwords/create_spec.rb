describe 'POST api/v1/auth/passwords', type: :request do
  let(:user) { create(:user) }
  let(:params) { { email: user.email } }

  subject do
    post api_v1_user_password_path, params: params, as: :json
    response
  end

  context 'when the user exists' do
  	it { is_expected.to have_http_status(:no_content) }
  end

  context 'when the user does not exist' do
  	let(:user) { build(:user) }

  	it 'returns credentials not valid message' do
      expect(json(subject)).to eq(error: 'Credentials not valid')
     end
  end
end
