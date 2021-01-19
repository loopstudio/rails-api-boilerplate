describe 'POST /api/v1/users/sign_in', { type: :request } do
  let(:request!) { post user_session_path, params: params, as: :json }
  let(:params) do
    {
      user: {
        email: email,
        password: password
      }
    }
  end
  let(:email) { user.email }
  let(:password) { user.password }
  let(:user) { create(:user, password: 'password', email: 'user@mail.com') }

  context 'with an existing email and password' do
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

    it 'returns if the user needs to change the password' do
      expect(json[:must_change_password]).to eq(user.must_change_password)
    end

    it 'returns a valid client and access token' do
      token = response.header['access-token']
      client = response.header['client']

      expect(user.reload).to be_valid_token(token, client)
    end
  end

  context 'when the password is invalid for the given email' do
    let(:password) { 'wrong_password' }

    include_examples 'have http status', :forbidden
  end

  context 'when the email does not exist' do
    let(:email) { 'wrong@email.com' }

    include_examples 'have http status', :forbidden
  end
end
