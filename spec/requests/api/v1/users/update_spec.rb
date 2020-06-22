require 'rails_helper'

describe 'PUT /api/v1/user', type: :request do
  let(:user) { create(:user) }

  context 'being signed in' do
    subject(:put_request) do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
    end

    shared_examples_for 'returns the user data' do
      specify do
        put_request

        user.reload
        expect(json[:user]).to include_json(
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          locale: user.locale
        )
      end
    end

    context 'not changing the password' do
      let(:params) do
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            locale: locale
          }
        }
      end

      let(:first_name) { 'Darth' }
      let(:last_name) { 'Vader' }
      let(:locale) { 'es' }

      specify do
        put_request

        expect(response).to have_http_status(:ok)
      end

      it_behaves_like 'returns the user data'
    end

    context 'changing the password' do
      let(:old_password) { 'oldPassword' }
      let(:new_password) { 'newPassword' }
      let(:user) { create(:user, password: old_password) }

      context 'without the password check' do
        let(:params) do
          {
            user: {
              password: new_password
            }
          }
        end

        specify do
          put_request

          expect(response).to have_http_status(:bad_request)
        end

        it 'returns an error' do
          put_request

          expect(json[:errors]).to include('The current password is not valid')
        end

        it 'does not update the user password' do
          put_request

          user.reload
          expect(user.valid_password?(old_password)).to eq(true)
          expect(user.valid_password?(new_password)).to eq(false)
        end
      end

      context 'with an invalid password check' do
        let(:params) do
          {
            user: {
              password: new_password
            },
            password_check: 'notThePassword'
          }
        end

        specify do
          put_request

          expect(response).to have_http_status(:bad_request)
        end

        it 'returns an error' do
          put_request

          expect(json[:errors]).to include('The current password is not valid')
        end

        it 'does not update the user password' do
          put_request

          user.reload
          expect(user.valid_password?(old_password)).to eq(true)
          expect(user.valid_password?(new_password)).to eq(false)
        end
      end

      context 'with the correct password check' do
        let(:params) do
          {
            user: {
              password: new_password
            },
            password_check: old_password
          }
        end

        specify do
          put_request

          expect(response).to have_http_status(:ok)
        end

        it 'updates the user password' do
          put_request

          user.reload
          expect(user.valid_password?(new_password)).to eq(true)
        end

        it_behaves_like 'returns the user data'
      end
    end
  end

  context 'not being signed in' do
    subject(:not_signed_in_request) do
      put api_v1_user_path, as: :json
    end

    include_examples 'not signed in examples'
  end
end
