# frozen_string_literal: true

module Users
  class Update < ApplicationService
    param :user
    param :params
    option :contract, default: -> { ::Users::UpdateForm }
    option :mailer, default: -> { ::EmailConfirmationMailer }

    CONFIRM_DURATION = 10.minutes

    def call
      valid_params = yield validate_contract(contract, params)

      if password_unchangeable?(valid_params)
        return Failure(Api::UnprocessableEntityError.new(old_password: I18n.t('api.errors.messages.old_password_fails')))
      end

      if user.email.nil? && valid_params[:email].present?
        return Failure(Api::UnprocessableEntityError.new(email: I18n.t('api.errors.messages.email_unchangeable')))
      end

      user_params = user_params(valid_params)
      user_params[:last_sent_confirmation_at] = DateTime.now if send_confirmation_available(user_params)

      user.update!(user_params)
      mailer.send_confirmation(user).deliver_later if send_confirmation_available(user_params)

      Success(user)
    end

    private

    def user_params(valid_params)
      user_params = {
        name: valid_params[:name],
        password: valid_params[:password],
        email: valid_params[:email]
      }.compact

      user_params[:email_confirmed] = false if user_params[:email].present?

      user_params
    end

    def send_confirmation_available(user_params)
      @send_confirmation_available ||= user_params[:email].present? || (!user.email_confirmed &&
                             (user.last_sent_confirmation_at.nil? || user.last_sent_confirmation_at <= CONFIRM_DURATION.ago))
    end

    def password_unchangeable?(valid_params)
      valid_params[:password].present? &&
        (user.email.nil? ||
        (valid_params[:old_password].nil? && user.password_present) ||
        (valid_params[:old_password] && !user.authenticate(valid_params[:old_password])))
    end
  end
end
