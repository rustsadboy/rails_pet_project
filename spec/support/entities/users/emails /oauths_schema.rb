# frozen_string_literal: true

module Entities
  module Users
    module Emails
      OAUTHS_SCHEMA = {
        type: :object,
        properties: {
          id: { type: :integer, example: 1 },
          name: { type: :string, example: 'Friend' },
          registration_completed: { type: :boolean, example: true }
        }
      }.freeze
    end
  end
end
