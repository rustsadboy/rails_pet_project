# frozen_string_literal: true

module Tokens
  class Validate < ::ApplicationService
    def call(token)
      jwt = JsonWebToken.decode(token)
      user = User.where(id: jwt['user_id']).first

      raise Api::UnauthorizedError if user.nil?

      user
    rescue JWT::ExpiredSignature
      raise Api::UnauthorizedError
    end
  end
end
