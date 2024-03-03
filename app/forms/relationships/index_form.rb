# frozen_string_literal: true

module Relationships
  class IndexForm < PaginateForm
    params do
      required(:user_id).value(:integer, gteq?: 1)
      optional(:query).value(:string)
    end
  end
end
