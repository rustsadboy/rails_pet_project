# frozen_string_literal: true

module Oauths
  module Apple
    class Client
      APPLE_ISSUER = 'https://appleid.apple.com'
      APPLE_JWKS_URI = 'https://appleid.apple.com/auth/keys'
      JWT_RS256 = 'RS256'

      def initialize(access_token: nil)
        @id_token = access_token
      end

      def call
        request = Faraday.new(url: APPLE_JWKS_URI)
        data = Oj.load(request.get.body, symbol_keys: true)
        raise Api::AccessForbiddenError.new(I18n.t('api.errors.forbidden_errors.public_key_missing')) unless data[:keys]

        payload = decode_token(data[:keys])
        raise Api::AccessForbiddenError.new(I18n.t('api.errors.forbidden_errors.token_not_verified')) unless payload

        payload['sub']
      end

      private

      def decode_token(public_keys)
        public_keys.each do |public_key|
          jwk = JWT::JWK.import(public_key)
          decoded_token = JWT.decode(
            @id_token,
            jwk.public_key,
            public_key.present?,
            decode_info
          )
          return decoded_token.first
        rescue JWT::JWKError
          raise Api::AccessForbiddenError.new(I18n.t('api.errors.forbidden_errors.invalid_public_key'))
        rescue JWT::ExpiredSignature
          raise Api::AccessForbiddenError.new(I18n.t('api.errors.forbidden_errors.token_expired'))
        rescue JWT::InvalidIssuerError
          raise Api::AccessForbiddenError.new(I18n.t('api.errors.forbidden_errors.token_not_verified'))
        rescue JWT::DecodeError
          nil # Try another public key.
        end

        false
      end

      def decode_info
        {
          algorithm: JWT_RS256,
          iss: APPLE_ISSUER,
          verify_iss: true
        }
      end
    end
  end
end
