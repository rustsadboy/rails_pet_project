# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users/{id}', type: :request do
  path '/api/users/{id}' do
    get 'Show user main data' do
      tags 'Profile'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true
      include_context :with_authenticated_user

      let(:user) { create(:user, :female) }
      let(:id) { user.id }

      response '200', 'user profile showed' do
        schema '$ref': '#/components/schemas/profiles'
        run_test! do
          expect(response_body['id']).to eq user.id
          expect(response_body['name']).to eq user.name
          expect(response_body['gender']).to eq 'female'
          expect(response_body['age']).to eq user.age
          expect(response_body['search_id']).to eq user.search_id
          expect(response_body['is_followed']).to be_nil
          expect(response_body['email_confirmed']).to eq true
        end
      end

      response '404', 'record not exists' do
        let(:id) { 0 }
        include_examples 'with error response 404'
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end
end
