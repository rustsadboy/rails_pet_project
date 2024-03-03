# frozen_string_literal: true

module Entities
  module Errors
    ERROR_SCHEMA_UNAUTHORIZED = {
      type: :object,
      properties: {
        errors: {
          type: :object,
          properties: {
            title: { type: :string, nullable: true, example: 'Authentication error' },
            status: { type: :integer, example: '401' },
            detail: { type: :string, nullable: true, example: 'Authentication needed' }
          }
        }
      }
    }.freeze
  end
end
