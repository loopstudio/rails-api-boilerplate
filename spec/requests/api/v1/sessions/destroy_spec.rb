describe 'DELETE /api/v1/users/sign_out', { type: :request } do
  let(:request!) { delete destroy_user_session_path, headers: headers, as: :json }
  let(:user) { create(:user) }

  context 'when being signed in' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :no_content

    it 'destroys the user token', skip_request: true do
      access_token = auth_headers['access-token']
      client = auth_headers['client']

      expect {
        request!
      }.to change { user.reload.valid_token?(access_token, client) }.from(true).to(false)
    end
  end

  context 'when not being signed in' do
    let(:headers) { nil }

    include_examples 'have http status with error',
                     :unauthorized,
                     I18n.t('devise.failure.unauthenticated')
  end
end
