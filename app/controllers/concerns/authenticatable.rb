module Authenticatable
  extend ActiveSupport::Concern

  class UnAuthorizedResource < StandardError
    def initialize(message = 'You are not authorized to access this resource')
      super(message)
    end
  end

  def current_user
    @current_user ||= User.find_by(id: request.env['current_user_id'])
  end

  def logged_in?
    current_user.present?
  end

  def validate_auth!
    raise Jwt::Errors::UnAuthorizedUser, 'Require login' unless logged_in?
  end

  def validate_owndership!(resource)
    raise UnAuthorizedResource, 'You are not authorized to access this resource' unless resource.user == current_user
  end

  class_methods do
    def require_auth!(only: [], except: [])
      before_action :validate_auth!, only: only.presence, except: except.presence
    end
  end
end
