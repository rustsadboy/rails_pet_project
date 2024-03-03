# frozen_string_literal: true

RSpec.shared_context :with_response_unauthorized do
  response '401', 'unauthorized error' do
    let(:Authorization) { nil }

    include_examples 'with error response 401'
  end
end
