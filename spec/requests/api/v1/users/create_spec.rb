describe 'POST /api/v1/users', { type: :request } do
  let(:request!) { post api_v1_users_path, params: params, as: :json }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let(:params) do
    {
      user: {
        first_name: 'Obi Wan',
        last_name: 'Kenobi',
        email: email,
        password: password,
        locale: 'es'
      }
    }
  end

  context 'with correct params given' do
    let(:created_user) { User.last }

    include_examples 'have http status', :ok

    specify do
      expect(json[:user]).to include_json(
        id: created_user.id,
        first_name: created_user.first_name,
        last_name: created_user.last_name,
        email: created_user.email,
        locale: created_user.locale
      )
    end

    it 'sets the authentication headers' do
      token = response.header['access-token']
      client = response.header['client']

      expect(created_user.reload).to be_valid_token(token, client)
    end
  end

  context 'with invalid params' do
    shared_examples 'missing parameter' do |field|
      let(field) { nil }

      include_examples 'have http status', :unprocessable_entity

      it { expect(json.dig(:attributes_errors, field)).to include("can't be blank") }
    end

    context 'when the email is missing' do
      include_examples 'missing parameter', :email
    end

    context 'when the password is missing' do
      include_examples 'missing parameter', :password
    end
  end
end
