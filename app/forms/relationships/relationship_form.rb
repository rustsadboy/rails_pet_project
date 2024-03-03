# frozen_string_literal: true

module Relationships
  class RelationshipForm < ApplicationForm
    params do
      required(:followed_id).value(:integer, gt?: 0)
    end
  end
end
