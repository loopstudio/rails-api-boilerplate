module Api
  module V1
    class UsersController < Api::V1::ApiController
      def show
        @user = User.find(params[:id])
        authorize @user
        render 'users/show', locals: { user: @user }
      end

      def index
        @users = policy_scope(User)
        render 'users/index'
      end
    end
  end
end
