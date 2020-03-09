module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      include ExceptionHandler
      include ActAsApiRequest
      include Localizable
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!, only: :destroy

      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        render(:create)
      end

      def render_destroy_success
        head(:no_content)
      end

      def render_create_error_bad_credentials
        render_errors(I18n.t('errors.authentication.invalid_credentials'), :forbidden)
      end
    end
  end
end
