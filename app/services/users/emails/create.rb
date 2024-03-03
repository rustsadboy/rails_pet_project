# frozen_string_literal: true

module Users
  module Emails
    class Create < ::ApplicationService
      param :params
      option :mailer, default: -> { ::EmailConfirmationMailer }
      option :contract, default: -> { ::Users::Emails::CreateForm }
      option :jwt, default: -> { ::Users::CreateJwt }
      option :generator, default: -> { ::CodeHelper }

      def call
        valid_params = yield validate_contract(contract, params)
        user = User.create!(
          email: valid_params[:email],
          name: valid_params[:name],
          password: valid_params[:password],
          registration_token: generator.generate_registration_token,
          last_sent_confirmation_at: DateTime.now
        )
        mailer.send_confirmation(user).deliver_later
        token = yield jwt.(user)

        Success(user:, token:)
      end
    end
  end
end
