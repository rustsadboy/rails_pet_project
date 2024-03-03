# frozen_string_literal: true

class TokenForm < ApplicationForm
  params do
    required(:token).value(:string)
  end
end
