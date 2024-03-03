# frozen_string_literal: true

module Users
  class IndexForm < ApplicationForm
    params do
      required(:search_id).value(:integer, gt?: 0)
    end
  end
end
