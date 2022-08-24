module Api
  class AuthenticationController < ApplicationController
    require_auth! only: :logout

    def shake
      render_response(username: current_user&.username)
    end

    def login
      username = params[:username]
      password = params[:password]

      @user = User.find_by(username: username)
      if @user&.authenticated?(password)
        access_token, refresh_token, exp_at = @user.to_token
        render_response(access_token: access_token, exp_at: exp_at, refresh_token: refresh_token)
      else
        render_error('Information provided is not correct', status: 401)
      end
    end

    def refresh
      @refresh_token = params[:refresh_token]

      access_token, refresh_token, exp_at = ::Jwt::RefreshService.call(@refresh_token)

      render_response(access_token: access_token, exp_at: exp_at, refresh_token: refresh_token)
    end

    def logout
      current_user.refresh_tokens.destroy_all

      render_response(success: true)
    end
  end
end
