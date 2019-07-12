module Api
  module V1
    module Auth
      class PasswordsController < DeviseTokenAuth::PasswordsController
        include ExceptionHandler

        before_action :set_user_by_token, only: [:update]
    
        def create
          raise ActionController::ParameterMissing.new(:email) unless resource_params[:email]

          email = get_case_insensitive_field_from_resource_params(:email)
          @resource = find_resource(:uid, email)

          raise InvalidCredentialsError.new unless @resource

          new_password = Devise.friendly_token.first(8)
          @resource.update!(password: new_password, must_change_password: true)

          UserMailer.with(user: @resource, new_password: new_password).reset_password_email.deliver_later
          
          head :no_content
        end

        def update
          raise InvalidCredentialsError.new unless @resource

          raise ActionController::ParameterMissing.new(:password) unless password_resource_params[:password]

          @resource.update!(
            password: password_resource_params[:password],
            must_change_password: false
          )

          head :no_content
        end
      end
    end
  end
end
