# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    delete 'Delete user profile' do
      tags 'Profile'

      include_context :api
      consumes 'application/json'
      produces 'application/json'

      include_context :with_authenticated_user

      response '200', 'Delete profile' do
        let(:user) { create(:user) }
        let!(:relationship) { create(:relationship, followed: user) }

        run_test! do |_|
          expect { user.reload }.to raise_error ActiveRecord::RecordNotFound
          expect { relationship.reload }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end
end
