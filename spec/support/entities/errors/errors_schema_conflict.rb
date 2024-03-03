# frozen_string_literal: true

module Entities
  module Errors
    ERROR_SCHEMA_CONFLICT = {
      type: :object,
      properties: {
        errors: {
          type: :object,
          properties: {
            title: { type: :string, nullable: true, example: 'Conflict' },
            status: { type: :integer, example: '409' },
            detail: { anyOf: [
              { type: :object, example: { user_id: 1, email: 'example@xyz.com' } },
              {
                type: :string,
                nullable: true,
                example: 'The request could not be completed due to a conflict with the current state of the resource'
              }
            ] }
          }
        }
      }
    }.freeze
  end
end
