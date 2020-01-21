module Api
  module V1
    class ApiController < ApplicationController
      include ExceptionHandler
      include ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagy::Backend

      before_action :authenticate_user!
      before_action :set_raven_context
    end
  end
end
