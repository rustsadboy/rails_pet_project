# frozen_string_literal: true

module Api
  class ConflictError < StandardError
    attr_reader :status, :detail

    def initialize(message = nil)
      super
      @detail = message
      @status = 409
    end

    def error_hash
      {
        title: I18n.t('api.errors.conflict'),
        status: @status,
        detail: @detail || I18n.t('api.errors.messages.conflict')
      }
    end
  end
end
