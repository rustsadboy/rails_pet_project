# frozen_string_literal: true

module Users
  class Create < ::ApplicationService
    param :user
    param :params
    option :contract, default: -> { ::Users::CreateForm }
    option :generator, default: -> { ::CodeHelper }

    SEARCH_ID_LENGTH = 5

    def call
      valid_params = yield validate_contract(contract, params)

      Db.transaction do
        user.update!(
          age: valid_params[:age],
          gender: valid_params[:gender],
          search_id: create_search_id,
          registration_completed: true
        )
      end

      Success(user)
    end

    private

    def create_search_id
      search_id = generator.search_id(SEARCH_ID_LENGTH)
      search_id = generator.search_id(SEARCH_ID_LENGTH) while User.exists?(search_id:)

      search_id
    end
  end
end
