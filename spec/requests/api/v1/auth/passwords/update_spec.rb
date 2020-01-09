describe 'PUT api/v1/auth/passwords', type: :request do
  subject(:put_request) do
    put api_v1_user_password_path, params: params, headers: headers, as: :json
  end

  let(:user) { create(:user, must_change_password: true, password: 'password') }
  let(:password) { 'abcd1234' }
  let(:params) { { password: password } }
  let(:headers) {}

  include_examples 'not signed in examples'

  context 'when the user is signed in' do
    let(:headers) { auth_headers(user) }

    context 'with valid params' do
      specify do
        put_request

        expect(response).to have_http_status(:no_content)
      end

      it "updates the current user's password" do
        put_request

        expect(user.reload.valid_password?('password')).to eq(false)
        expect(user.valid_password?(password)).to eq(true)
      end

      it "updates the current user's must_change_password flag" do
        put_request

        expect(user.reload.must_change_password).to eq(false)
      end
    end
  end
end
