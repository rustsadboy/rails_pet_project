# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users/{user_id}/followers', type: :request do
  path '/api/users/{user_id}/followers' do
    get 'Show user\'s subscribers' do
      tags 'Profile'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, in: :path, type: :integer, required: true
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :limit, in: :query, type: :integer, required: false
      parameter name: :query, in: :query, type: :string, required: false
      include_context :with_authenticated_user

      let(:user) { create(:user) }
      let!(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let!(:relationship) { create(:relationship, follower_id: user2.id, followed_id: user.id) }
      let(:user_id) { user.id }

      response '200', 'user subscriptions showed' do
        schema '$ref': '#/components/schemas/subs'

        run_test! do
          expect(response_body['users'].first['id']).to eq user2.id
          expect(response_body['users'].first['name']).to eq user2.name
          expect(response_body['meta']['users_count']).to eq 1
        end
      end

      response '404', 'record not exists' do
        let(:user_id) { user.id + 100 }
        include_examples 'with error response 404'
      end

      response '422', 'invalid param' do
        let(:user_id) { -1 }
        include_examples 'with error response 422', I18n.t('dry_validation.errors.gteq?.failure', num: 1)
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end
end
