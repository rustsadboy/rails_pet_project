# frozen_string_literal: true

module Macros
  module PasswordUpdateMacros
    extend ActiveSupport::Concern

    included do
      register_macro(:password_update) do
        key.failure(I18n.t('api.errors.messages.new_password_needed')) if values[:password_confirmation].present? &&
                                                                          values[:password].nil?

        key.failure(I18n.t('api.errors.messages.password_confirmation_needed')) if values[:password].present? &&
                                                                                   values[:password_confirmation].nil?

        key.failure(I18n.t('api.errors.messages.passwords_do_not_match')) if values[:password].present? &&
                                                                             values[:password_confirmation].present? &&
                                                                             values[:password] != values[:password_confirmation]
      end
    end
  end
end
