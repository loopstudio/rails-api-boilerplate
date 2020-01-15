describe 'GET api/v1/auth/token_validations', type: :request do
  subject(:get_request) do
    get api_v1_auth_validate_token_path, headers: headers, as: :json
  end

  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  context 'with a live auth token' do
    specify do
      get_request

      expect(response).to have_http_status(:ok)
    end

    it "returns the logged in user's data" do
      get_request

      expect(json).to include_json(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        created_at: user.created_at.as_json,
        updated_at: user.updated_at.as_json
      )
    end

    it 'returns response with the authentication headers' do
      get api_v1_auth_validate_token_path, headers: headers, as: :json

      token = response.header['access-token']
      client = response.header['client']

      expect(user.reload.valid_token?(token, client)).to be_truthy
    end
  end

  context 'with an incorrect auth token' do
    let(:user) { build(:user) }

    specify do
      get_request

      expect(response).to have_http_status(:forbidden)
    end

    it 'returns invalid token error' do
      get_request

      expect(json[:errors]).to include(I18n.t('errors.authentication.invalid_token'))
    end
  end
end
