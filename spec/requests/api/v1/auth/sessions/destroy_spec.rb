describe 'DELETE api/v1/auth/sessions', type: :request do
  subject(:delete_request) do
    delete destroy_api_v1_user_session_path, headers: headers, as: :json
  end

  let(:user) { create(:user) }
  let(:headers) {}

  include_examples 'not signed in examples'

  context 'with correct headers' do
    let(:headers) { auth_headers(user) }

    context 'when the user exists' do
      specify do
        delete_request

        expect(response).to have_http_status(:no_content)
      end

      it 'returns no authentication headers' do
        delete_request

        expect(response.header['access-token']).to eq nil
        expect(response.header['client']).to eq nil
      end

      it 'destroys the client token' do
        expect(user.tokens.any?).to be_falsey
      end
    end

    context 'when the user does not exist' do
      let(:user) { build(:user) }

      specify do
        delete_request

        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns no authentication headers' do
        delete_request

        expect(response.header['access-token']).to eq nil
        expect(response.header['client']).to eq nil
      end
    end
  end
end
