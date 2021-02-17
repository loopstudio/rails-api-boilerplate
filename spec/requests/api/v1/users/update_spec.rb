describe 'PUT /api/v1/user', { type: :request } do
  let(:request!) { put api_v1_user_path, params: params, headers: headers, as: :json }

  context 'when being signed in' do
    let(:headers) { auth_headers }

    before { user.reload }

    context 'when not changing the password' do
      let(:user) { create(:user) }
      let(:params) do
        {
          user: {
            first_name: 'Darth',
            last_name: 'Vader',
            locale: 'es'
          }
        }
      end

      include_examples 'have http status', :ok

      specify do
        expect(json[:user]).to include_json(
          first_name: 'Darth',
          last_name: 'Vader',
          locale: 'es'
        )
      end
    end

    context 'when changing the password' do
      let(:user) { create(:user, password: 'oldPassword') }

      shared_examples 'invalid password' do
        include_examples 'have http status with error',
                         :bad_request,
                         'The current password is not valid'

        it { expect(user.valid_password?('oldPassword')).to be(true) }
        it { expect(user.valid_password?('newPassword')).to be(false) }
      end

      context 'without the password check' do
        let(:params) { { user: { password: 'newPassword' } } }

        include_examples 'invalid password'
      end

      context 'with the password check' do
        let(:params) { { user: { password: 'newPassword' }, password_check: password_check } }

        context 'with an invalid password check' do
          let(:password_check) { 'notThePassword' }

          include_examples 'invalid password'
        end

        context 'with the correct password check' do
          let(:password_check) { 'oldPassword' }

          include_examples 'have http status', :ok

          it { expect(user.valid_password?('newPassword')).to be(true) }

          specify do
            expect(json[:user]).to include_json(
              id: user.id,
              first_name: user.first_name,
              last_name: user.last_name,
              email: user.email,
              locale: user.locale
            )
          end
        end
      end
    end
  end

  context 'when not being signed in' do
    let(:params) { nil }

    it_behaves_like 'an authenticated endpoint'
  end
end
