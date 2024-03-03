# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload, exp = 100.year.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY'))
  end

  def self.decode(token)
    JWT.decode(token, ENV.fetch('JWT_SECRET_KEY'))[0]
  rescue JWT::DecodeError
    raise Api::UnauthorizedError
  end
end
