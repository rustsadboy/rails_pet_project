# frozen_string_literal: true

module Users
  module Emails
    module Confirmations
      class Index < ::ApplicationService
        param :params
        option :contract, default: -> { ::TokenForm }
        option :generator, default: -> { ::CodeHelper }

        def call
          valid_params = yield validate_contract(contract, params)
          decoded_data = generator.decode_token(valid_params[:token])
          user = User.find_by!(email: decoded_data[:email], email_confirmed: false)

          if user.registration_token == decoded_data[:registration_token]
            user.email_confirmed = true
            user.registration_token = nil
            user.save!

            return Success(I18n.t('api.success.messages.confirmation'))
          end

          Failure(
            Api::UnprocessableEntityError.new(
              registration_token: I18n.t('api.errors.messages.invalid_registration_token')
            )
          )
        end
      end
    end
  end
end
