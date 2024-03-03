# frozen_string_literal: true

module Relationships
  class Index < ApplicationService
    param :params
    param :relationship
    option :contract, default: -> { ::Relationships::IndexForm }

    def call
      valid_params = yield validate_contract(contract, params)
      user = User.find(valid_params[:user_id])
      relation = user.send(relationship).order(id: :desc)
      relation_count = relation.count
      relation = relation.where('name ILIKE ?', "%#{valid_params[:query]}%") if valid_params[:query].present?

      Success(
        relation: relation.page(valid_params[:page]).per(valid_params[:limit] || 10),
        relation_count:
      )
    end
  end
end
