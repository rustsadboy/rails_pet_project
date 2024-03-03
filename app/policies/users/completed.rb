# frozen_string_literal: true

module Users
  class Completed < ::ApplicationPolicy
    def call(user)
      user.registration_completed?
    end
  end
end
