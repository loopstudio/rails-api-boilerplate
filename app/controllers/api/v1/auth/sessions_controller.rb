module Api
  module V1
  	module Auth
  		class SessionsController < DeviseTokenAuth::SessionsController
  			include ExceptionHandler

  			private
  			
	    	def render_create_success
					render 'auth/show', locals: { user: @resource }
				end

				def render_destroy_success
					render json: nil, status: :no_content
				end

				def render_create_error_bad_credentials
					raise InvalidCredentialsError.new
			  end

			  def render_destroy_error
					raise InvalidCredentialsError.new
			  end
	    end
  	end
  end
end
