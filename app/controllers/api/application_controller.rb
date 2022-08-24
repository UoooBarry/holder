module Api
  class ApplicationController < ApplicationController
    include Authenticatable

    def render_error(message, status: 500)
      content = {
        meta: {
          status: status,
          message: message
        },
        payload: {}
      }

      render json: content, status: status
    end

    def render_response(content)
      content = {
        meta: {
          status: 200,
          message: 'success'
        },
        payload: content
      }

      render json: content, status: :ok
    end

    rescue_from ActiveRecord::ActiveRecordError, ActiveRecord::RecordInvalid do |exception|
      render_error(exception.message, status: 400)
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render_error(exception.message, status: 404)
    end

    rescue_from ::Jwt::Errors::UnAuthorizedUser, ::Jwt::Errors::MissingToken do |exception|
      render_error(exception.message, status: 403)
    end

    rescue_from ActionController::ParameterMissing do
      render_error('Parameters provided is incorrect or missing', status: 400)
    end
  end
end
