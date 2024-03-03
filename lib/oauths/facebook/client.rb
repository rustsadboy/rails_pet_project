# frozen_string_literal: true

module Oauths
  module Facebook
    class Client
      BASE_URL = 'https://graph.facebook.com/debug_token'.freeze

      def initialize(access_token: nil)
        @access_token = access_token
      end

      def call
        request = Faraday.new(
          url: BASE_URL,
          params: {
            access_token: "#{ENV.fetch('FACEBOOK_CLIENT_ID', nil)}|#{ENV.fetch('FACEBOOK_CLIENT_SECRET', nil)}",
            input_token: @access_token
          },
          headers: { 'Content-Type' => 'application/json' }
        )

        data = Oj.load(request.get.body, symbol_keys: true)
        raise Api::AccessForbiddenError.new(data[:error][:message]) if data[:error].present?

        data[:data][:user_id]
      end
    end
  end
end
