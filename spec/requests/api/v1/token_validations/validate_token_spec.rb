describe 'GET /api/v1/users/validate_token', { type: :request } do
  let(:request!) { get api_v1_users_validate_token_path, headers: headers, as: :json }
  let(:user) { create(:user) }

  context 'when being signed in' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :ok

    specify do
      expect(json[:user]).to include_json(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        locale: user.locale
      )
    end

    it 'returns valid authentication headers' do
      token = response.header['access-token']
      client = response.header['client']

      expect(user.reload).to be_valid_token(token, client)
    end
  end

  context 'when not being signed in' do
    let(:headers) { nil }

    include_examples 'have http status with error',
                     :forbidden,
                     I18n.t('errors.authentication.invalid_token')
  end
end
