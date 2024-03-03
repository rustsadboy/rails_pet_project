# frozen_string_literal: true

module Entities
  module Errors
    ERROR_SCHEMA_NOT_FOUND = {
      type: :object,
      properties: {
        errors: {
          type: :object,
          properties: {
            title: { type: :string, nullable: true, example: 'Record not found' },
            status: { type: :integer, example: '404' },
            detail: { type: :string, nullable: true, example: 'Record not exists' },
            model_name: { type: :string, nullable: true, example: 'string' }
          }
        }
      }
    }.freeze
  end
end
