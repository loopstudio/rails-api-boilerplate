module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      include ExceptionHandler
      include ActAsApiRequest

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end

      def account_update_params
        params.require(:user).permit(:email, :first_name, :password, :last_name)
      end

      def render_create_success
        render :create
      end

      def render_update_success
        render :update
      end

      def render_destroy_success
        head :no_content
      end

      def render_update_error
        raise ActiveRecord::RecordInvalid, @resource
      end

      def render_update_error_user_not_found
        render_errors(I18n.t('devise.failure.unauthenticated'), :unauthorized)
      end

      def render_destroy_error
        render_errors(I18n.t('devise.failure.unauthenticated'), :unauthorized)
      end

      def render_create_error
        raise ActiveRecord::RecordInvalid, @resource
      end

      def validate_post_data(which, message)
        render_errors(message, :unprocessable_entity) if which.empty?
      end
    end
  end
end
