module Api
  module V1
    class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
      include ExceptionHandler
      include ActAsApiRequest
      include Localizable

      def render_validate_token_success
        render :validate
      end

      def render_validate_token_error
        render_errors(I18n.t('errors.authentication.invalid_token'), :forbidden)
      end
    end
  end
end
