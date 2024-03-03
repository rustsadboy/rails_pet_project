# frozen_string_literal: true

module Entities
  module Users
    REGISTERED_SCHEMA = {
      type: :object,
      properties: {
        id: { type: :integer, example: 1, required: true },
        email: { type: :string, example: 'default@mail.com', required: true },
        registration_completed: { type: :boolean, example: true, required: true },
        gender: { type: :string, enum: User::GENDERS, required: true },
        age: { type: :string, enum: User::AGES, required: true }
      }
    }.freeze
  end
end
