# frozen_string_literal: true

module Entities
  module Users
    module Emails
      EMAILS_SCHEMA = {
        type: :object,
        properties: {
          id: { type: :integer, example: 1 },
          email_confirmed: { type: :boolean, example: true },
          registration_completed: { type: :boolean, example: true }
        }
      }.freeze
    end
  end
end
