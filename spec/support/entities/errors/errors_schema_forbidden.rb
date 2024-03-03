# frozen_string_literal: true

module Entities
  module Errors
    ERROR_SCHEMA_FORBIDDEN = {
      type: :object,
      properties: {
        errors: {
          type: :object,
          properties: {
            title: { type: :string, nullable: true, example: 'Access forbidden' },
            status: { type: :integer, example: '403' },
            detail: { type: :string, nullable: true, example: 'Access to requested resource forbidden' }
          }
        }
      }
    }.freeze
  end
end
