# frozen_string_literal: true

module Entities
  module Users
    PROFILES_SCHEMA = {
      type: :object,
      properties: {
        id: { type: :integer, example: 1, required: true },
        followings_count: { type: :integer, required: true },
        followers_count: { type: :integer, required: true },
        name: { type: :string, required: true },
        search_id: { type: :integer, example: 11_111, required: true },
        is_followed: { type: :boolean, nullable: true },
        email_confirmed: { type: :boolean, nullable: true },
        password_present: { type: :boolean, nullable: true },
        email: { type: :string, example: 'default@mail.com', required: true },
        gender: { type: :string, enum: User::GENDERS, required: true },
        age: { type: :string, enum: User::AGES, nullable: true }
      }
    }.freeze
  end
end
