describe 'POST api/v1/auth/registrations', type: :request do
  subject(:post_request) do
    post api_v1_user_registration_path, params: params, as: :json
  end

  let(:first_name) { 'Obi Wan' }
  let(:last_name) { 'Kenobi' }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let(:params) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password
    }
  end

  context 'with correct params given' do
    let(:created_user) { User.last }

    specify do
      post_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns the user info' do
      post_request

      expect(json).to include_json(
        id: created_user.id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        created_at: created_user.created_at.as_json,
        updated_at: created_user.updated_at.as_json
      )
    end

    it 'sets the authentication headers' do
      post api_v1_user_registration_path, params: params, as: :json

      token = response.header['access-token']
      client = response.header['client']

      expect(created_user.valid_token?(token, client)).to be_truthy
    end
  end

  context 'with params missing' do
    context 'when any required param is given' do
      let(:params) { {} }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the first_name is missing' do
      let(:first_name) { nil }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post_request

        expect(json[:errors][0][:first_name]).not_to be_nil
      end
    end

    context 'when the last name is missing' do
      let(:last_name) { nil }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post_request

        expect(json[:errors][0][:last_name]).not_to be_nil
      end
    end

    context 'when the email is missing' do
      let(:email) { nil }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post_request

        expect(json[:errors][0][:email]).not_to be_nil
      end
    end

    context 'when the password is missing' do
      let(:password) { nil }

      specify do
        post_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post_request

        expect(json[:errors][0][:password]).not_to be_nil
      end
    end
  end
end
