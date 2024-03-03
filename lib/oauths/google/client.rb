# frozen_string_literal: true

module Oauths
  module Google
    class Client
      BASE_URL = 'https://oauth2.googleapis.com/tokeninfo'.freeze

      def initialize(access_token: nil)
        @access_token = access_token
      end

      def call
        request = Faraday.new(
          url: BASE_URL,
          params: {
            id_token: @access_token
          },
          headers: { 'Content-Type' => 'application/json' }
        )
        data = Oj.load(request.get.body, symbol_keys: true)
        raise Api::AccessForbiddenError.new(data[:error_description]) if data[:error_description].present?

        data[:sub]
      end
    end
  end
end
