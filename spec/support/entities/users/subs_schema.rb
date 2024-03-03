# frozen_string_literal: true

module Entities
  module Users
    SUBS_SCHEMA = {
      type: :object,
      properties: {
        users: {
          type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1, required: true },
              name: { type: :string, required: true }
            }
          }
        },
        meta: {
          type: :object,
          properties: {
            users_count: { type: :integer, required: true }
          }
        }
      }
    }.freeze
  end
end
