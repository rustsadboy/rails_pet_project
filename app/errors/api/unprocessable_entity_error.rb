# frozen_string_literal: true

module Api
  class UnprocessableEntityError < StandardError
    attr_reader :status, :detail

    def initialize(errors)
      super
      @errors = errors
      @status = 422
      error_hash
    end

    def error_hash
      errors_array = @errors.map do |e|
        @field = e.first
        @detail = e.last
        @detail = e.last.first if e.last.is_a?(Array)
        @detail = e.last[e.last.keys.first].first if e.last.is_a?(Hash)

        {
          title: I18n.t('api.errors.unprocessable_entity_exception'),
          status: @status,
          source: { pointer: "data/attributes/#{@field}" },
          detail: @detail
        }
      end

      errors_array.first
    end
  end
end
