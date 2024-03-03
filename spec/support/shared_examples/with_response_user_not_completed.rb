# frozen_string_literal: true

RSpec.shared_context :with_response_user_not_completed do
  response '403', 'user not completed' do
    let!(:user) { create(:user, registration_completed: false) }

    include_examples 'with error response 403'
  end
end
