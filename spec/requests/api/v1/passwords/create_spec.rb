require 'rails_helper'

describe 'POST /api/v1/users/password', type: :request do
  subject(:post_request) do
    post user_password_path, params: params, as: :json
  end

  let(:user) { create(:user, password: 'old password') }

  context 'when the email exists' do
    let(:params) { { email: user.email } }

    specify do
      post_request

      expect(response).to have_http_status(:no_content)
    end

    it 'sends an email with the new password' do
      expect {
        post_request
      }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
        .with(UserMailer.to_s, 'reset_password_email', 'deliver_now', anything)
    end

    it 'sets the user to have to change the password' do
      expect {
        post_request
      }.to change { user.reload.must_change_password }.from(false).to(true)
    end

    it 'assigns the user a new password' do
      expect {
        post_request
      }.to change { user.reload.valid_password?('old password') }.from(true).to(false)
    end
  end

  context 'when the email does not exist' do
    let(:params) { { email: 'wrong@email.com' } }

    specify do
      post_request

      expect(response).to have_http_status(:not_found)
    end

    it 'does not send an email' do
      expect {
        post_request
      }.to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end
end
