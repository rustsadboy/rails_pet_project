# frozen_string_literal: true

module Oauths
  class CreateForm < ApplicationForm
    params do
      required(:access_token).value(:string)
      required(:provider).value(:string, included_in?: UserOauth::PROVIDERS)
      optional(:email).value(:string)
      optional(:name).value(:string, min_size?: 2, max_size?: 20)
    end

    rule(:email).validate(:email_format)
  end
end
