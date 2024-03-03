# frozen_string_literal: true

module Users
  class CreateJwt < ::ApplicationService
    param :user
    option :jwt, default: -> { ::JsonWebToken }

    def call
      Success(jwt.encode({ user_id: user.id.to_s }))
    end
  end
end
