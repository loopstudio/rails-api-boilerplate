module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include ActAsApiRequest
      include Localizable
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagy::Backend

      before_action :authenticate_user!
    end
  end
end
