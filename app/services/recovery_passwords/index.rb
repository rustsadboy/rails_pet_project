# frozen_string_literal: true

module RecoveryPasswords
  class Index < ::ApplicationService
    param :params
    option :mailer, default: -> { ::ResetPasswordMailer }
    option :contract, default: -> { ::TokenForm }
    option :generator, default: -> { ::CodeHelper }
    option :find_user, default: -> { ::RecoveryPasswords::FindUser }

    def call
      valid_params = yield validate_contract(contract, params)
      decoded_data = generator.decode_token(valid_params[:token])
      user = yield find_user.(decoded_data[:email])

      if decoded_data[:expired_at].to_datetime < DateTime.now ||
         user.recovery_password_expired_at.nil?
        return Failure(
          Api::UnprocessableEntityError.new(
            token: I18n.t('api.errors.messages.recovery_token_expired')
          )
        )
      end

      new_password = generator.generate_password
      user.update!(password: new_password, recovery_password_expired_at: nil)
      mailer.send_new_password(user, new_password).deliver_later

      Success(I18n.t('api.success.messages.password_reset'))
    end
  end
end
