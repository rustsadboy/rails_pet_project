# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    put 'Update user' do
      tags 'Profile'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :kwargs, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Aboba' },
          email: { type: :string, example: 'test@example.com' },
          old_password: { type: :string, example: 'lublu_ulitok_228' },
          password: { type: :string, example: 'heil_snail_1397' },
          password_confirmation: { type: :string, example: 'heil_snail_1397' }
        }
      }

      include_context :with_authenticated_user

      let(:user) { create(:user, password: 'lublu_ulitok_228') }
      let(:name) { 'Snailer' }
      let(:email) { 'snail_lover@snail.com' }
      let(:old_password) { 'lublu_ulitok_228' }
      let(:password) { 'heil_snail_1397' }
      let(:password_confirmation) { 'heil_snail_1397' }

      let(:kwargs) do
        {
          name:,
          email:,
          old_password:,
          password:,
          password_confirmation:
        }
      end

      response '200', 'user profile showed and updated' do
        schema '$ref': '#/components/schemas/profiles'

        run_test! do
          user.reload
          expect(response_body['id']).to eq user.id
          expect(response_body['name']).to eq user.name && kwargs[:name]
          expect(user.email).to eq kwargs[:email]
          expect(user.authenticate(password)).to eq user
        end
      end

      response '422', 'does not update user' do
        let(:kwargs) do
          {
            name:,
            email:,
            old_password:,
            password:,
            password_confirmation:
          }
        end
        let(:old_password) { 'ya_lublu_ulitok' }

        include_examples 'with error response 422', I18n.t('api.errors.messages.old_password_fails')
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end
end
