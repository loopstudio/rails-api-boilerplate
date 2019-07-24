describe 'POST api/v1/auth/passwords', type: :request do
  let(:user) { create(:user) }
  let(:params) { { email: user.email } }
  let(:headers) { auth_headers(user) }

  subject do
    post api_v1_user_password_path, params: params, headers: headers, as: :json
    response
  end

  it { is_expected.to have_http_status(:no_content) }
end
