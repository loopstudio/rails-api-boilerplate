module Api
  module V1
    class PasswordsController < DeviseTokenAuth::PasswordsController
      include ExceptionHandler
      include ActAsApiRequest
      include Localizable
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :validate_redirect_url_param, only: []

      def edit
        @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

        head(:no_content) && return if @resource&.reset_password_period_valid?

        render_token_invalid
      end

      def update
        @resource = resource_class.reset_password_by_token(update_params)
        errors = @resource.errors

        if errors.empty?
          response.headers.merge!(@resource.create_new_auth_token)
          render_update_success
        else
          token_error = errors.messages.key?(:reset_password_token)
          token_error ? render_token_invalid : render_attributes_errors(errors)
        end
      end

      private

      def render_create_success
        head(:no_content)
      end

      def render_update_success
        render('api/v1/users/show', locals: { user: @resource })
      end

      def render_token_invalid
        render_errors([I18n.t('errors.invalid_reset_password_token')], :bad_request)
      end

      def update_params
        params.permit(:reset_password_token, :password, :password_confirmation)
      end
    end
  end
end
