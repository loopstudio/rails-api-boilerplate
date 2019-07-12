module Api
  module V1
  	module Auth
  		class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
  			include ExceptionHandler

	    	private

	    	def render_validate_token_success
					render 'auth/show', locals: { user: @resource }
				end

				def render_validate_token_error
					raise InvalidTokenError.new
			  end
	    end
  	end
  end
end
