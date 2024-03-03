# frozen_string_literal: true

module Sessions
  class CreateForm < ApplicationForm
    params do
      required(:email).value(:string)
      required(:password).value(:string, min_size?: 8, max_size?: 30)
    end

    rule(:email).validate(:email_format)
  end
end
