# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    get 'Find user by id' do
      tags 'Profile'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :search_id, in: :query, type: :integer, required: true
      include_context :with_authenticated_user

      let(:user) { create(:user, search_id: 1488) }
      let(:search_id) { user.search_id }

      response '200', 'user profile showed' do
        schema '$ref': '#/components/schemas/profiles'

        run_test! do
          expect(response_body['id']).to eq user.id
          expect(response_body['name']).to eq user.name
          expect(response_body['search_id']).to eq user.search_id
          expect(response_body['is_followed']).to be_nil
        end
      end

      response '200', 'user profile showed' do
        schema '$ref': '#/components/schemas/profiles'

        let(:following) { create(:user) }
        let!(:relationship) { create(:relationship, follower: user, followed: following) }
        let(:search_id) { following.search_id }

        run_test! do
          expect(response_body['id']).to eq following.id
          expect(response_body['name']).to eq following.name
          expect(response_body['search_id']).to eq following.search_id
          expect(response_body['is_followed']).to eq true
        end
      end

      response '422', 'invalid param' do
        let(:search_id) { -1 }
        include_examples 'with error response 422', 'must be greater than 0'
      end

      response '404', 'record not exists' do
        let(:search_id) { user.search_id - 228 }
        include_examples 'with error response 404'
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end
end
