module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Api::V1::Concerns::AuthenticateUser
    end
  end
end
