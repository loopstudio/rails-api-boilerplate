shared_examples 'an authenticated endpoint' do
  let(:headers) { nil }

  include_examples 'have http status with error',
                   :unauthorized,
                   I18n.t('devise.failure.unauthenticated')
end
