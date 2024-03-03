# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    post 'Create user' do
      tags 'Profile'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          age: { type: :string, enum: User::AGES },
          gender: { type: :string, enum: User::GENDERS }
        },
        required: %i[age gender]
      }

      include_context :with_authenticated_user

      let(:age) { User::AGES.first }
      let(:gender) { User::GENDERS.first }
      let(:data) { { age:, gender: } }

      response '200', 'user registration completed' do
        schema '$ref': '#/components/schemas/user_registered'

        run_test! do
          expect(response_body['id']).to eq user.id
          expect(response_body['email']).to eq user.email
          expect(response_body['age']).to eq age
          expect(response_body['gender']).to eq gender
        end
      end

      response '422', 'does not update user' do
        let(:age) { 'pozhiloy' }

        include_examples 'with error response 422', I18n.t('dry_validation.errors.included_in?.failure')
      end

      include_context :with_response_unauthorized
    end
  end
end
