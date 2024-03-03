# frozen_string_literal: true

module RecoveryPasswords
  class CreateForm < ApplicationForm
    params do
      required(:email).value(:string)
    end

    rule(:email).validate(:email_format)
  end
end
