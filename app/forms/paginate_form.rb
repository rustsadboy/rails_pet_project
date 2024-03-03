# frozen_string_literal: true

class PaginateForm < ApplicationForm
  params do
    optional(:page).value(:integer, gteq?: 1)
    optional(:limit).value(:integer, gteq?: 1)
  end
end
