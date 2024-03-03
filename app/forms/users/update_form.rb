# frozen_string_literal: true

module Users
  class UpdateForm < ApplicationForm
    params do
      optional(:name).value(:string)
      optional(:email).value(:string)
      optional(:old_password).value(:string)
      optional(:password).value(:string)
      optional(:password_confirmation).value(:string)
    end

    rule(:email).validate(:email_format)
    rule(:email).validate(:email_uniq)
    rule(:password, :old_password, :password_confirmation).validate(:password_update)
  end
end
