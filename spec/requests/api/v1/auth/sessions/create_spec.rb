describe 'POST api/v1/auth/sessions', type: :request do
  let(:email) { 'obikenobi@rebel.com' }
  let(:password) { 'abcd1234' }
  let(:user) { create(:user, email: email, password: password) }
  let(:params) { { email: email, password: password } }

  subject do
    post new_api_v1_user_session_path, params: params, as: :json
    response
  end

  context 'wxith correct params' do
    context 'when user is registered' do
      before do
        user
      end

      it { is_expected.to have_http_status(:ok) }

      it 'returns user & session information' do
        expect(json_response(subject)).to eq(
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

      it 'sets authentication headers' do
        post new_api_v1_user_session_path, params: params, as: :json

        token = response.header['access-token']
        client = response.header['client']

        expect(user.reload.valid_token?(token, client)).to be_truthy
      end
    end

    context 'when user is not registered' do
      it { is_expected.to have_http_status(:forbidden) }

      it 'returns user & session information' do
        expect(json_response(subject)).to eq(
          error: 'Credentials not valid'
        )
      end
    end
  end

  context 'wxith missing params' do
    context 'when any required param is given' do
      let(:params) { {} }

      it { is_expected.to have_http_status(:forbidden) }
    end

    context 'when missing password' do
      let(:params) { { email: email, password: nil } }

      it { is_expected.to have_http_status(:forbidden) }

      it 'returns missing first_name param message' do
        expect(json_response(subject)).to eq(
          error: 'Credentials not valid'
        )
      end
    end
  end
end
