describe 'PUT api/v1/auth/registrations', type: :request do

  subject do
    put api_v1_user_registration_path, params: params, headers: headers, as: :json
    response
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
      it { is_expected.to have_http_status(:ok) }

      it 'returns updated user info' do
        put api_v1_user_registration_path, params: params, headers: headers, as: :json

        expected_response = {
          id: user.id,
          first_name: first_name,
          last_name: last_name,
          email: user.email,
          created_at: user.created_at.as_json,
          updated_at: user.reload.updated_at.as_json
        }

        expect(json(response)).to eq(expected_response)
      end
    end

    context 'with invalid params' do
      let(:params) { nil }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it 'returns not valid credentials error' do
        expect(json(subject)).to eq(
          errors: ['Please submit proper account update data in request body.']
        )
      end

      context 'when trying to update user password' do
        let(:params) { { password: 'password' } }

        it 'returns not valid credentials error' do
          expect(json(subject)).to eq(
            errors: ['Please submit proper account update data in request body.']
          )
        end
      end
    end
  end
end
