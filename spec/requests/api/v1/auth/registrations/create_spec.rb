describe 'POST api/v1/auth/registrations', type: :request do
  subject do
    post api_v1_user_registration_path, params: params, as: :json
    response
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

    it { is_expected.to have_http_status(:ok) }

    it 'returns the user info' do
      post api_v1_user_registration_path, params: params, as: :json

      expected_response = {
        id: created_user.id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        created_at: created_user.created_at.as_json,
        updated_at: created_user.updated_at.as_json
      }

      expect(json(response)).to eq(expected_response)
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

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context 'when the first_name is missing' do
      let(:first_name) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns an error message' do
        expect(json(subject)).to eq(
          errors: [{ first_name: ["can't be blank"] }]
        )
      end
    end

    context 'when the last name is missing' do
      let(:last_name) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns an error message' do
        expect(json(subject)).to eq(
          errors: [{ last_name: ["can't be blank"] }]
        )
      end
    end

    context 'when the email is missing' do
      let(:email) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns an error message' do
        expect(json(subject)).to eq(
          errors: [{ email: ["can't be blank"] }]
        )
      end
    end

    context 'when the password is missing' do
      let(:password) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns an error message' do
        expect(json(subject)).to eq(
          errors: [{ password: ["can't be blank"] }]
        )
      end
    end
  end
end
