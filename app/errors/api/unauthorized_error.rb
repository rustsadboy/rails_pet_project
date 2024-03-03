# frozen_string_literal: true

module Api
  class UnauthorizedError < StandardError
    attr_reader :status, :detail

    def initialize(message = nil)
      super
      @detail = message
      @status = 401
    end

    def error_hash
      {
        title: I18n.t('api.errors.authentication'),
        status: @status,
        detail: @detail || I18n.t('api.errors.messages.not_logged_in')
      }
    end
  end
end
