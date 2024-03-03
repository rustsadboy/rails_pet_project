# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/relationships', type: :request do
  path '/api/relationships' do
    delete 'Unfollow user' do
      tags 'Subscription'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :data, in: :body, schema: {
        type: :object,
        properties: {
          followed_id: { type: :integer, example: 1 }
        },
        required: :followed_id
      }

      include_context :with_authenticated_user

      let(:user) { create(:user) }
      let(:user1) { create(:user) }
      let!(:relationship) { create(:relationship, follower: user, followed: user1) }
      let(:followed_id) { user1.id }
      let(:data) { { followed_id: } }

      response '200', 'user subscribes' do
        run_test! do
          expect(response_body).to be_empty
          expect(user.followings).to eq []
          expect(user1.followers).to eq []
        end
      end

      response '422', 'self-subsription' do
        let(:followed_id) { 'sobaka' }

        include_examples 'with error response 422', I18n.t('dry_validation.errors.int?.failure')
      end

      response '404', 'user not found' do
        let(:followed_id) { user1.id + 1 }

        include_examples 'with error response 404'
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end
end
