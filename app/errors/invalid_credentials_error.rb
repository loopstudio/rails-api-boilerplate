class InvalidCredentialsError < StandardError
  def message
    I18n.t('errors.authentication.invalid_credentials')
  end
end
