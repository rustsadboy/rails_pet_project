# frozen_string_literal: true

module Macros
  module Emails
    module EmailUniqMacros
      extend ActiveSupport::Concern

      included do
        register_macro(:email_uniq) do |_macro:|
          key.failure(I18n.t('api.errors.messages.email_already_exists')) if values[:email].present? &&
                                                                             User.exists?(email: values[:email])
        end
      end
    end
  end
end
