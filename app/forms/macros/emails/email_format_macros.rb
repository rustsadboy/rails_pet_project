# frozen_string_literal: true

module Macros
  module Emails
    module EmailFormatMacros
      extend ActiveSupport::Concern

      included do
        register_macro(:email_format) do |_macro:|
          key.failure(I18n.t('api.errors.messages.invalid_email_format')) unless values[:email].nil? || valid_email_format?(values[:email])
        end

        def valid_email_format?(email)
          /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i.match?(email)
        end
      end
    end
  end
end
