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

    it 'sends an email with the reset password token' do
      expect {
        post_request
      }.to have_enqueued_email(Devise::Mailer, :reset_password_instructions)
    end

    it 'changes the user reset password token' do
      expect {
        post_request
      }.to(change { user.reload.reset_password_token })
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

  context 'without an email' do
    let(:params) { { email: nil } }

    specify do
      post_request

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
