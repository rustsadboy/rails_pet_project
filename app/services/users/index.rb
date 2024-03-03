# frozen_string_literal: true

module Users
  class Index < ApplicationService
    param :params
    option :contract, default: -> { ::Users::IndexForm }

    def call
      valid_params = yield validate_contract(contract, params)

      Success(User.find_by!(search_id: valid_params[:search_id]))
    end
  end
end
