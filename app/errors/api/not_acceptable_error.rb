# frozen_string_literal: true

module Api
  class NotAcceptableError < StandardError
    attr_reader :status, :detail

    def initialize(message = nil)
      super
      @detail = message
      @status = 406
    end

    def error_hash
      {
        title: I18n.t('api.errors.not_acceptable'),
        status: @status,
        detail: @detail || I18n.t('api.errors.messages.not_acceptable')
      }
    end
  end
end
