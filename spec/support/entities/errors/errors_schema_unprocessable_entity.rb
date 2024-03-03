# frozen_string_literal: true

module Entities
  module Errors
    ERROR_SCHEMA_UNPROCESSABLE_ENTITY = {
      type: :object,
      properties: {
        errors: {
          type: :object,
          properties: {
            title: { type: :string, nullable: true, example: 'string' },
            status: { type: :integer, example: '422' },
            detail: { type: :string, nullable: true, example: 'string' },
            source: {
              type: :object,
              properties: {
                pointer: { type: :string, nullable: true, example: 'data/attributes/<field>' }
              }
            }
          }
        }
      }
    }.freeze
  end
end
