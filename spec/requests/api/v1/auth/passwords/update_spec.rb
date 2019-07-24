describe 'PUT api/v1/auth/passwords', type: :request do
  let(:user) { create(:user, must_change_password: true, password: 'password') }
  let(:password) { 'abcd1234' }
  let(:headers) { auth_headers(user) }
  let(:params) { { password: password } }

  subject do
    put api_v1_user_password_path, params: params, headers: headers, as: :json
    response
  end

  context 'when credentials given' do
    context 'when valid params' do
      it { is_expected.to have_http_status(:no_content) }

      it 'updates logged user password' do
        subject
        expect(user.reload.valid_password?('password')).to eq(false)
        expect(user.valid_password?(password)).to eq(true)
      end

      it 'updates logged user must_change_password flag' do
        subject
        expect(user.reload.must_change_password).to eq(false)
      end
    end
  end

  context 'when no credentials given' do
    let(:headers) {}

    it { is_expected.to have_http_status(:forbidden) }
  end
end
