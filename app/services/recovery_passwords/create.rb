# frozen_string_literal: true

module RecoveryPasswords
  class Create < ::ApplicationService
    param :params
    option :mailer, default: -> { ::SubmitRecoveryPasswordMailer }
    option :contract, default: -> { ::RecoveryPasswords::CreateForm }
    option :generator, default: -> { ::CodeHelper }
    option :find_user, default: -> { ::RecoveryPasswords::FindUser }

    def call
      valid_params = yield validate_contract(contract, params)
      user = yield find_user.(valid_params[:email])

      if user.recovery_password_expired_at && DateTime.now < user.recovery_password_expired_at
        return Failure(
          Api::UnprocessableEntityError.new(
            recovery: I18n.t('api.errors.messages.recovery_already_created')
          )
        )
      end

      user.update!(
        recovery_password_expired_at: DateTime.now + ENV.fetch('RECOVERY_EXPIRED_TIME').to_i.hours
      )
      mailer.send_submit(user).deliver_later

      Success(user)
    end
  end
end
