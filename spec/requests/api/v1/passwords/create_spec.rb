describe 'POST /api/v1/users/password', { type: :request } do
  let(:request!) { post user_password_path, params: params, as: :json }
  let(:user) { create(:user, password: 'old password') }

  context 'with an email' do
    context 'when the email exists' do
      let(:params) { { email: user.email } }

      include_examples 'have http status', :no_content

      it 'sends an email with the reset password token', skip_request: true do
        expect { request! }.to have_enqueued_email(Devise::Mailer, :reset_password_instructions)
      end

      it 'changes the user reset password token', skip_request: true do
        expect { request! }.to(change { user.reload.reset_password_token })
      end
    end

    context 'when the email does not exist' do
      let(:params) { { email: 'wrong@email.com' } }

      include_examples 'have http status', :not_found

      it 'does not send an email', skip_request: true do
        expect { request! }.not_to(change { ActionMailer::Base.deliveries.count })
      end
    end
  end

  context 'without an email' do
    let(:params) { { email: nil } }

    include_examples 'have http status', :unauthorized
  end
end
