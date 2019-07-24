describe 'DELETE api/v1/auth/sessions', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  subject do
    delete destroy_api_v1_user_session_path, headers: headers, as: :json
    response
  end

  context 'with correct headers' do
    context 'when session exists' do
      it { is_expected.to have_http_status(:no_content) }

      it 'returns no authentication headers' do
        expect(subject.header['access-token']).to eq nil
        expect(response.header['client']).to eq nil
      end
    end

    context 'when session does not exists' do
      let(:user) { build(:user) }

      it { is_expected.to have_http_status(:forbidden) }

      it 'returns no authentication headers' do
        expect(subject.header['access-token']).to eq nil
        expect(response.header['client']).to eq nil
      end
    end
  end

  context 'with missing headers' do
    subject do
      delete destroy_api_v1_user_session_path, as: :json
      response
    end

    it { is_expected.to have_http_status(:forbidden) }
  end
end
