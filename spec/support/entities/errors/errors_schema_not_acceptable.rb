# frozen_string_literal: true

module Entities
  module Errors
    ERROR_SCHEMA_NOT_ACCEPTABLE = {
      type: :object,
      properties: {
        errors: {
          type: :object,
          properties: {
            title: { type: :string, nullable: true, example: 'Not Acceptable' },
            status: { type: :integer, example: '406' },
            detail: { anyOf: [
              { type: :object, example: { status: 'expired', message: 'The auto-renewable subscription is expired' } },
              {
                type: :string,
                nullable: true,
                example: 'Unable to provide a response that matches the requested format'
              }
            ] }
          }
        }
      }
    }.freeze
  end
end
