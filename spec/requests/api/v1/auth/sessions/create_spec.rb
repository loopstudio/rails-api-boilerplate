describe 'POST api/v1/auth/sessions', type: :request do
  subject(:post_request) do
    post new_api_v1_user_session_path, params: params, as: :json
  end

  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let!(:user) { create(:user, email: email, password: password) }
  let(:params) { { email: email, password: password } }

  context 'with correct params' do
    context 'when the user is registered' do
      specify do
        post_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the user & session information' do
        post_request

        expect(json).to include_json(
          user: {
            id: user.id,
            first_name: user.first_name,
            last_name: user.last_name,
            email: user.email,
            created_at: user.created_at.as_json,
            updated_at: user.reload.updated_at.as_json
          },
          must_change_password: user.must_change_password
        )
      end

      it 'sets the authentication headers' do
        post new_api_v1_user_session_path, params: params, as: :json

        token = response.header['access-token']
        client = response.header['client']

        expect(user.reload.valid_token?(token, client)).to be_truthy
      end
    end

    context 'when the user is not registered' do
      let(:user) {}

      specify do
        post_request

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns the user & session information' do
        post_request

        expect(json[:errors][0]).not_to be_nil
      end
    end
  end

  context 'with missing params' do
    context 'when any required param is given' do
      let(:params) { {} }

      specify do
        post_request

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when the password is missing' do
      let(:params) { { email: email, password: nil } }

      specify do
        post_request

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        post_request

        expect(json[:errors][0]).not_to be_nil
      end
    end
  end
end
