module Api
  module V1
    class UsersController < Api::V1::ApiController
      def profile
        render :profile
      end
    end
  end
end
