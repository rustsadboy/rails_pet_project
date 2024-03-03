# frozen_string_literal: true

module JwtAuthorizable
  extend ActiveSupport::Concern

  included do
    before_action :validate_token
  end

  def validate_token
    user = Tokens::Validate.new.(request.headers['Authorization'])
    user.mark_activity!
  end

  def current_user
    @current_user ||= begin
      payload = JsonWebToken.decode(request.headers['Authorization'])
      User.find(payload['user_id'])
    end
  end
end
