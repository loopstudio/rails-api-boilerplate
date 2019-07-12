class InvalidTokenError < StandardError
  def message
    I18n.t('errors.authentication.invalid_token')
  end
end
