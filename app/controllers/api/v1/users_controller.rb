module Api
  module V1
    class UsersController < Api::V1::ApiController
      helper_method :user

      def show; end

      private

      def user
        @user ||= current_user
      end
    end
  end
end
