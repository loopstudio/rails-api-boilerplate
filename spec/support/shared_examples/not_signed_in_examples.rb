shared_examples 'not signed in examples' do
  before { subject }

  it { expect(response).to have_http_status(:unauthorized) }
  it { expect(json[:errors]).to include(I18n.t('devise.failure.unauthenticated')) }
end
