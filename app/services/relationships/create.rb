# frozen_string_literal: true

module Relationships
  class Create < ApplicationService
    param :user
    param :params
    option :contract, default: -> { ::Relationships::RelationshipForm }

    def call
      valid_params = yield validate_contract(contract, params)

      if user.id == valid_params[:followed_id]
        return Failure(Api::UnprocessableEntityError.new(followed_id: I18n.t('api.errors.messages.self_subscription')))
      end

      followed_user = User.find(valid_params[:followed_id])

      if user.following?(followed_user)
        return Failure(Api::UnprocessableEntityError.new(followed_id: I18n.t('api.errors.messages.already_subscribed')))
      end

      Success(user.follow(followed_user))
    end
  end
end
