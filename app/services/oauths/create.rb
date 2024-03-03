# frozen_string_literal: true

module Oauths
  class Create < ApplicationService
    param :params
    option :contract, default: -> { ::Oauths::CreateForm }
    option :jwt, default: -> { ::Users::CreateJwt }

    def call
      valid_params = yield validate_contract(contract, params)

      obj = Oauths.const_get(valid_params[:provider].capitalize)
      uid = obj::Client.new(access_token: valid_params[:access_token]).call
      user = Db.transaction do
        user_oauth = UserOauth.find_or_initialize_by(provider: valid_params[:provider], uid:)
        define_user(user_oauth, valid_params[:name], valid_params[:email])
      end

      token = yield jwt.(user)

      Success(user:, token:)
    end

    private

    def define_user(user_oauth, name, email)
      return user_oauth.user if user_oauth.persisted?

      user = User.find_by(email:) if email.present?

      if user.nil?
        user = User.create!(email:, name: name || 'Friend', email_confirmed: true)
      elsif !user.email_confirmed
        user.update!(email_confirmed: true)
      end

      user_oauth.user = user
      user_oauth.save!

      user
    end
  end
end
