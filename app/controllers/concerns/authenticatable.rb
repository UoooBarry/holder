module Authenticatable
  extend ActiveSupport::Concern

  def current_user
    request.env['current_user']
  end

  def logged_in?
    current_user.present?
  end

  def validate_auth!
    raise Jwt::Errors::UnAuthorizedUser, 'Require login' unless logged_in?
  end

  class_methods do
    def require_auth!(only: [], except: [])
      before_action :validate_auth!, only: only.presence, except: except.presence
    end
  end
end
