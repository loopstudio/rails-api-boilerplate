module Api
  module V1
    module Concerns
      module AuthenticateUser
        extend ActiveSupport::Concern

        included do
          before_action :authenticate_user!
        end

        def authenticate_user!
          return if current_api_v1_user

          render_errors(I18n.t('errors.authentication.authentication_needed'), :forbidden)
        end
      end
    end
  end
end
