# frozen_string_literal: true

module Sessions
  class Create < ::ApplicationService
    param :params
    option :contract, default: -> { ::Sessions::CreateForm }
    option :jwt, default: -> { ::Users::CreateJwt }

    def call
      valid_params = yield validate_contract(contract, params)
      user = User.find_by!(email: valid_params[:email])

      unless user.authenticate(valid_params[:password])
        return Failure(
          Api::UnauthorizedError.new(I18n.t('api.errors.messages.incorrect_password'))
        )
      end
      token = yield jwt.(user)

      Success(user:, token:)
    end
  end
end
