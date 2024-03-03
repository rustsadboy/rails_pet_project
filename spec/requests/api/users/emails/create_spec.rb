# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users/emails', type: :request do
  include ActiveJob::TestHelper

  path '/api/users/emails' do
    post 'Email registration' do
      tags 'Registration/Authorization'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'bebra@mail.ru' },
          name: { type: :string, example: 'mrBebra' },
          password: { type: :string, example: 'supersecret' }
        },
        required: %i[email name password]
      }

      let(:email) { 'bebra@mail.ru' }
      let(:name) { 'mrBebra' }
      let(:password) { 'supersecret' }
      let(:data) { { email:, name:, password: } }

      before do
        stub_const(
          'ENV', {
            'GMAIL_EMAIL' => 'slava.bebro@gmail.com',
            'ROUTES_HOST' => 'https://wwww.my-pet.com',
            'JWT_SECRET_KEY' => 'secret'
          }
        )
      end

      response '200', 'email registered and confirmation link sended' do
        schema '$ref': '#/components/schemas/emails'
        run_test! do |response|
          expect(response_body['id']).to eq User.first.id
          expect(response_body['email_confirmed']).to be_falsey
          expect(response_body['registration_completed']).to be_falsey
          expect(response.headers['Authorization']).not_to be_nil
          assert_enqueued_with(job: EmailConfirmationMailer.delivery_job, queue: 'mailers')
        end
      end

      response '422', 'email already exists' do
        let!(:user) { create(:user, email:) }

        include_examples 'with error response 422', I18n.t('api.errors.messages.email_already_exists')
      end
    end
  end
end
