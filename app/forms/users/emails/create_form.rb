# frozen_string_literal: true

module Users
  module Emails
    class CreateForm < ApplicationForm
      params do
        required(:email).value(:string)
        required(:name).value(:string, min_size?: 2, max_size?: 20)
        required(:password).value(:string, min_size?: 8, max_size?: 30)
      end

      rule(:email).validate(:email_format)
      rule(:email).validate(:email_uniq)
    end
  end
end
