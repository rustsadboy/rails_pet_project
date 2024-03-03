# frozen_string_literal: true

module RecoveryPasswords
  class FindUser < ::ApplicationService
    param :email

    def call
      user = User.find_by!(email:)
      unless user.email_confirmed? && user.password_present
        return Failure(
          Api::AccessForbiddenError.new(I18n.t('api.errors.messages.email_not_confirmed'))
        )
      end

      Success(user)
    end
  end
end
