module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagy::Backend

      before_action :authenticate_api_v1_user!
      before_action :set_raven_context
    end
  end
end
