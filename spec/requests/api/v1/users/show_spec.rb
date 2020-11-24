describe 'GET /api/v1/user', type: :request do
  let(:user) { create(:user) }

  context 'when being signed in' do
    subject(:get_request) do
      get api_v1_user_path, headers: auth_headers, as: :json
    end

    specify do
      get_request

      expect(response).to have_http_status(:success)
    end

    it 'returns the user data' do
      get_request

      expect(json[:user]).to include_json(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        locale: user.locale
      )
    end
  end

  context 'when not being signed in' do
    subject(:not_sign_in_request) do
      get api_v1_user_path, as: :json
    end

    include_examples 'not signed in examples'
  end
end
