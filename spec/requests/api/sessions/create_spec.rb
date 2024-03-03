# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/sessions', type: :request do
  path '/api/sessions' do
    post 'Authorization' do
      tags 'Registration/Authorization'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'bebra@mail.ru' },
          password: { type: :string, example: 'supersecret' }
        },
        required: %i[email password]
      }

      let!(:user) { create(:user, email:, password:) }
      let(:email) { 'bebra@mail.ru' }
      let(:password) { 'supersecret' }
      let(:data) { { email:, password: } }

      before do
        stub_const(
          'ENV', {
            'JWT_SECRET_KEY' => 'secret'
          }
        )
      end

      response '200', 'success authorization' do
        schema '$ref': '#/components/schemas/authorization'
        run_test! do |response|
          expect(response_body['id']).to eq user.id
          expect(response_body['email_confirmed']).to eq user.email_confirmed
          expect(response_body['registration_completed']).to eq user.registration_completed
          expect(response.headers['Authorization']).not_to be_nil
        end
      end

      response '404', 'email not found' do
        let(:another_email) { 'monada@mail.ru' }
        let(:data) { { email: another_email, password: } }

        include_examples 'with error response 404', I18n.t('api.errors.messages.record_not_exists')
      end

      response '401', 'password incorrect' do
        let(:another_password) { 'no_batches?' }
        let(:data) { { email:, password: another_password } }

        include_examples 'with error response 401', I18n.t('api.errors.messages.incorrect_password')
      end
    end
  end
end
