require 'addressable/uri'

describe 'GET api/v1/users/password/edit', { type: :request } do
  let(:request!) { get edit_user_password_path, params: params, headers: headers, as: :json }
  let(:params) { { reset_password_token: password_token } }
  let!(:password_token) { user.send(:set_reset_password_token) }
  let(:user) { create(:user) }

  context 'with a valid token' do
    include_examples 'have http status', :no_content
  end

  context 'with an expired token' do
    before do
      sent_at = user.reset_password_sent_at - Devise.reset_password_within - 1.second
      user.update!(reset_password_sent_at: sent_at)

      request!
    end

    include_examples 'have http status with error',
                     :bad_request,
                     I18n.t('errors.invalid_reset_password_token'),
                     skip_request: true
  end

  context 'with an invalid token' do
    let(:password_token) { 'invalid token' }

    include_examples 'have http status with error',
                     :bad_request,
                     I18n.t('errors.invalid_reset_password_token')
  end
end
