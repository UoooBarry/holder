module Api
  class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      @user.save!

      access_token, refresh_token, exp_at = @user.to_token
      render_response(sucess: true, access_token: access_token, exp_at: exp_at, refresh_token: refresh_token)
    end

    private

    def user_params
      params.permit(:username, :password, :email, :bio, :gender, :age)
    end
  end
end
