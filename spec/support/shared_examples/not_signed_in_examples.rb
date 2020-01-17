shared_examples 'not signed in examples' do
  it 'returns an unauthorized error' do
    subject

    expect(response).to have_http_status(:unauthorized)
    expect(json[:errors]).to include(I18n.t('devise.failure.unauthenticated'))
  end
end
