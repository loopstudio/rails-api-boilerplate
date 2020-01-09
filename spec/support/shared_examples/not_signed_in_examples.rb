shared_examples 'not signed in examples' do
  context 'when the user is not signed in' do
    specify do
      subject

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns authentication required error' do
      subject

      expect(json[:errors]).to include(I18n.t('devise.failure.unauthenticated'))
    end
  end
end
