describe 'PUT api/v1/auth/registrations', type: :request do
  subject(:put_request) do
    put api_v1_user_registration_path, params: params, headers: headers, as: :json
  end

  let(:user) { create(:user) }
  let(:first_name) { 'Darth' }
  let(:last_name) { 'Vader' }
  let(:params) do
    {
      first_name: first_name,
      last_name: last_name
    }
  end

  include_examples 'not signed in examples'

  context 'when the user is signed in' do
    let(:headers) { auth_headers(user) }

    context 'with valid params' do
      specify do
        put_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns updated user info' do
        put_request

        expect(json).to include_json(
          id: user.id,
          first_name: first_name,
          last_name: last_name,
          email: user.email,
          created_at: user.created_at.as_json,
          updated_at: user.reload.updated_at.as_json
        )
      end
    end

    context 'with invalid params' do
      let(:params) { nil }

      specify do
        put_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns not valid credentials error' do
        put_request

        expect(json[:errors][0]).not_to be_nil
      end

      context 'when trying to update user password' do
        let(:params) { { password: 'password' } }

        it 'returns not valid credentials error' do
          put_request

          expect(json[:errors][0]).not_to be_nil
        end
      end
    end
  end
end
