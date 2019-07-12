module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        include ExceptionHandler
        
        private

        def sign_up_params
          params.require(:user).permit(:email, :password, :first_name, :last_name)
        end

        def account_update_params
          params.permit(:email, :first_name, :last_name)
        end

        def render_create_success
          render 'auth/show', locals: { user: @resource }
        end

        def render_update_success
          render 'users/show', locals: { user: @resource }
        end

        def render_destroy_success
          render json: nil, status: :no_content
        end

        def render_update_error_user_not_found
          raise InvalidCredentialsError.new
        end

        def render_destroy_error
          raise InvalidCredentialsError.new
        end

        def render_create_error
          raise ActiveRecord::RecordInvalid.new(@resource)
        end
      end
    end
  end
end
