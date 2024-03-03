# frozen_string_literal: true

module Api
  class AccessForbiddenError < StandardError
    attr_reader :status, :detail

    def initialize(message = nil)
      super
      @detail = message
      @status = 403
    end

    def error_hash
      {
        title: I18n.t('api.errors.access_forbidden'),
        status: @status,
        detail: @detail || I18n.t('api.errors.messages.access_forbidden')
      }
    end
  end
end
