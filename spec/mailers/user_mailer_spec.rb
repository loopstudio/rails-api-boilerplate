describe UserMailer, type: :mailer do
  describe 'reset_password_email' do
    let(:user) { create(:user) }
    let(:new_password) { 'password' }
    let(:mail) { UserMailer.with(user: user, new_password: new_password).reset_password_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Recover account')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end
end
