describe 'POST api/v1/auth/registrations', type: :request do
  let(:first_name) { 'Obi Wan' }
  let(:last_name) { 'Kenobi' }
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let(:params) do
    {
      user:
        {
          first_name: first_name,
          last_name: last_name,
          email: email,
          password: password
        }
    }
  end

  subject do
    post api_v1_user_registration_path, params: params, as: :json
    response
  end

  context 'with correct params' do
    let (:created_user) { User.last }

    it { is_expected.to have_http_status(:ok) }

    it 'returns user info' do
      post api_v1_user_registration_path, params: params, as: :json

      expected_response = {
        id: created_user.id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        created_at: created_user.created_at.as_json,
        updated_at: created_user.updated_at.as_json
      }

      expect(json_response(response)).to eq(expected_response)
    end

    it 'sets authentication headers' do
      post api_v1_user_registration_path, params: params, as: :json

      token = response.header['access-token']
      client = response.header['client']

      expect(created_user.valid_token?(token, client)).to be_truthy
    end
  end

  context 'with missing params' do
    context 'when any required param is given' do
      let(:params) { {} }

      it { is_expected.to have_http_status(:bad_request) }
    end

    context 'when missing first_name' do
      let(:first_name) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns missing first_name param message' do
        expect(json_response(subject)).to eq(
          error: 'First name can\'t be blank'
        )
      end
    end

    context 'when missing last_name' do
      let(:last_name) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns missing last_name param message' do
        expect(json_response(subject)).to eq(
          error: 'Last name can\'t be blank'
        )
      end
    end

    context 'when missing email' do
      let(:email) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns missing email param message' do
        expect(json_response(subject)).to eq(
          error: 'Email can\'t be blank'
        )
      end
    end

    context 'when missing password' do
      let(:password) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns missing password param message' do
        expect(json_response(subject)).to eq(
          error: 'Password can\'t be blank'
        )
      end
    end
  end
end
