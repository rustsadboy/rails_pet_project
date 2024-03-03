# frozen_string_literal: true

module Relationships
  class Destroy < ApplicationService
    param :current_user
    param :params
    option :contract, default: -> { ::Relationships::RelationshipForm }

    def call
      valid_params = yield validate_contract(contract, params)

      followed_user = current_user.followings.find(valid_params[:followed_id])

      Success(current_user.unfollow(followed_user))
    end
  end
end
