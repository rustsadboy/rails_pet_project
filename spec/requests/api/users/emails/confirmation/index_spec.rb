# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users/emails/confirmations', type: :request do
  include ActiveJob::TestHelper

  path '/api/users/emails/confirmations' do
    get 'Email confirmaiton' do
      tags 'Registration/Authorization'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :token, in: :query, type: :string, example: 'secret', required: true

      let(:user) do
        create(
          :user,
          email: 'abobebrus@snail.ru',
          email_confirmed: false,
          registration_token: CodeHelper.generate_registration_token
        )
      end

      response '200', 'email confirmed' do
        let(:token) do
          CodeHelper.generate_confirmation_token(
            user.email,
            user.registration_token
          )
        end

        run_test! do |response|
          expect(response.body).to match I18n.t('api.success.messages.confirmation')
          expect(user.reload.email_confirmed).to eq true
        end
      end

      response '422', 'invalid registration token' do
        let(:token) do
          CodeHelper.generate_confirmation_token(user.email, 'asdasdasd')
        end

        run_test! do |response|
          expect(response.body).to match I18n.t('api.errors.messages.invalid_registration_token')
          expect(user.reload.email_confirmed).to eq false
        end
      end

      response '404', 'email not found' do
        let(:token) do
          CodeHelper.generate_confirmation_token('abobing@snail.ru', 'asdasdasd')
        end

        include_examples 'with error response 404', I18n.t('api.errors.messages.record_not_exists')
      end
    end
  end
end
