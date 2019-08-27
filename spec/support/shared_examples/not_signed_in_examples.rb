shared_examples 'not signed in examples' do
  context 'when the user is not signed in' do
    it { is_expected.to have_http_status(:unauthorized) }

    it 'returns authentication required error' do
      expect(json(subject)).to eq(
        errors: [I18n.t('devise.failure.unauthenticated')]
      )
    end
  end 
end
