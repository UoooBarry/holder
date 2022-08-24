require_relative './base'

module Middleware
  class AuthMiddleware < Base
    def call(env)
      status, headers, response = @app.call(env)
      authroization_header = env['HTTP_AUTHORIZATION']&.split&.last

      if authroization_header
        begin
          @decoded = JsonWebToken.decode(authroization_header)
          env['current_user'] = User.find(@decoded[:id])
          return @app.call(env)
        rescue ActiveRecord::RecordNotFound, JWT::DecodeError
          response = [{
            meta: {
              status: 403,
              message: 'Invalid token'
            }
          }.to_json]
          status = 403
        end
      end

      [status, headers, response]
    end
  end
end
