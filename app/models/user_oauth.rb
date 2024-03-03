# frozen_string_literal: true

class UserOauth < ApplicationRecord
  belongs_to :user

  enum provider: %i[apple google facebook]

  PROVIDERS = providers.keys.freeze
end
