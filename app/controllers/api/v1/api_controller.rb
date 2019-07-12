module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
    	include DeviseTokenAuth::Concerns::SetUserByToken
    	include Pundit

    	def current_user
    		current_api_v1_user
  		end
		end
  end
end
