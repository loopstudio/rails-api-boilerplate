describe 'GET api/v1/auth/token_validations', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  subject do
    get api_v1_auth_validate_token_path, headers: headers, as: :json
    response
  end

  context 'with live auth token' do
    it { is_expected.to have_http_status(:ok) }

    it "returns the logged in user's data" do
      expect(json(subject)).to eq(
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

    it { is_expected.to have_http_status(:forbidden) }

    it 'returns invalid token error' do
      expect(json(subject)).to eq(
        error: I18n.t('errors.authentication.invalid_token')
      )
    end
  end
end
