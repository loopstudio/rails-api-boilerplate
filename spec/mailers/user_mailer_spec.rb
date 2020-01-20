require 'rails_helper'

describe UserMailer, type: :mailer do
  describe 'reset_password_email' do
    let(:user) { create(:user) }
    let(:new_password) { 'password' }
    subject(:mailer_action) { UserMailer.reset_password_email(user, new_password) }

    it 'renders the headers' do
      expect(mailer_action.subject).to eq(I18n.t('emails.reset_password.recover_account'))
      expect(mailer_action.to).to include(user.email)
      expect(mailer_action.from).to include('from@example.com')
    end
  end
end
