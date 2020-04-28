module Api
  module V1
    class PasswordsController < DeviseTokenAuth::PasswordsController
      include ExceptionHandler
      include ActAsApiRequest
      include Localizable
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :validate_redirect_url_param, only: []
      before_action :validate_email_param, only: :create
      before_action :authenticate_user!, only: :update
      before_action :validate_password_param, only: :update

      def create
        email = get_case_insensitive_field_from_resource_params(:email)
        user = User.find_by!(email: email)
        ::Auth::ResetPasswordService.call(user)
        head(:no_content)
      end

      def update
        current_user.update!(
          password: password_resource_params[:password],
          must_change_password: false
        )

        head(:no_content)
      end

      private

      def validate_email_param
        return if resource_params[:email]

        raise(ActionController::ParameterMissing, :email)
      end

      def validate_password_param
        return if password_resource_params[:password]

        raise(ActionController::ParameterMissing, :password)
      end
    end
  end
end
