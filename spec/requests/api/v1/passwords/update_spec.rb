require 'addressable/uri'

describe 'PUT api/v1/users/password/', { type: :request } do
  let(:request!) { put user_password_path, params: params, headers: headers, as: :json }
  let(:user) { create(:user) }
  let!(:password_token) { user.send(:set_reset_password_token) }
  let(:new_password) { '123456789aA?!' }
  let(:params) do
    {
      reset_password_token: password_token,
      password: new_password
    }
  end

  context 'with a valid token' do
    context 'with valid params' do
      it 'updates the user password', skip_request: true do
        expect { request! }.to(change { user.reload.encrypted_password })
      end

      include_examples 'have http status', :ok

      it { expect(user.reload).to be_valid_password(new_password) }

      it 'returns the user data' do
        expect(json[:user]).to include_json(id: user.id,
                                            first_name: user.first_name,
                                            last_name: user.last_name,
                                            email: user.email)
      end

      it 'returns a valid client and access token' do
        token = response.header['access-token']
        client = response.header['client']

        expect(user.reload).to be_valid_token(token, client)
      end
    end

    context 'with invalid params' do
      let(:new_password) { nil }

      include_examples 'have http status', :unprocessable_entity

      it { expect(json[:attributes_errors]).not_to have_key('reset_password_token') }

      it 'does not change the user password', skip_request: true do
        expect { request! }.not_to change(user.reload, :encrypted_password)
      end
    end
  end

  context 'with an invalid token' do
    let(:password_token) { 'invalid token' }

    include_examples 'have http status', :bad_request

    it { expect(user.reload).not_to be_valid_password(new_password) }

    it 'does not change the user password', skip_request: true do
      expect { request! }.not_to change(user.reload, :encrypted_password)
    end
  end
end
