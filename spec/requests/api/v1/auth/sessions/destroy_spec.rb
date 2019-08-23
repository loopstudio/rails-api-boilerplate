describe 'DELETE api/v1/auth/sessions', type: :request do
  let(:user) { create(:user) }
  let(:headers) {  }

  subject do
    delete destroy_api_v1_user_session_path, headers: headers, as: :json
    response
  end

  include_examples 'not signed in examples'

  context 'with correct headers' do
    let(:headers) { auth_headers(user) }

    context 'when the session exists' do
      it { is_expected.to have_http_status(:no_content) }

      it 'returns no authentication headers' do
        expect(subject.header['access-token']).to eq nil
        expect(response.header['client']).to eq nil
      end

      it 'destroys the client token' do
        expect(user.tokens.any?).to be_falsey
      end
    end

    context 'when the session does not exist' do
      let(:user) { build(:user) }

      it { is_expected.to have_http_status(:forbidden) }

      it 'returns no authentication headers' do
        expect(subject.header['access-token']).to eq nil
        expect(response.header['client']).to eq nil
      end
    end
  end
end
