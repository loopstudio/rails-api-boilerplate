shared_examples 'not signed in examples' do
  context 'when the user is not signed in' do
    it { is_expected.to have_http_status(:forbidden) }

    it 'returns authentication required error' do
      expect(json(subject)).to eq(
        error: I18n.t('errors.authentication.authentication_needed')
      )
    end
  end 
end
