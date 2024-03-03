# frozen_string_literal: true

module CodeHelper
  BASE_URL = ENV.fetch('ROUTES_HOST', 'http://localhost:3000')

  class << self
    def generate_registration_token
      (0...30).map { ('a'..'z').to_a[rand(26)] }.join
    end

    def generate_confirmation_token(email, registration_token)
      JsonWebToken.encode({ email:, registration_token: })
    end

    def decode_token(token)
      JsonWebToken.decode(token).symbolize_keys!
    end

    def generate_confirmation_url(user)
      token = generate_confirmation_token(user.email, user.registration_token)

      "#{BASE_URL}/api/users/emails/confirmations?token=#{token}"
    end

    def generate_recovery_token(email, expired_at)
      JsonWebToken.encode({ email:, expired_at: })
    end

    def generate_password
      (0...12).map { ('a'..'z').to_a[rand(26)] }.join
    end

    def generate_recovery_url(user)
      token = generate_recovery_token(user.email, user.recovery_password_expired_at)

      "#{BASE_URL}/api/recovery_passwords?token=#{token}"
    end

    def search_id(length)
      [rand(1...10)].append((length - 1).times.map { rand(10) }).join
    end
  end
end
