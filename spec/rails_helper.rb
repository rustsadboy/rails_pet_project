# frozen_string_literal: true

# rubocop: disable
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
require 'vcr'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.shared_context :api do
  let(:response_body) { JSON.parse(response.body) }
  let(:response_data) { JSON.parse(response.body)['data'] }
  let(:response_included) { JSON.parse(response.body)['included'] }
  let(:response_errors) { JSON.parse(response.body)['errors'] }
  let(:response_attributes) { JSON.parse(response.body)['data']['attributes'] }
  let(:empty_response) { { 'data' => nil, 'errors' => nil } }
end

RSpec.configure do |config|
  config.include_context :api
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :controller)
  config.include ActiveSupport::Testing::TimeHelpers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.ignore_hosts '127.0.0.1', 'localhost'
  config.hook_into :webmock
end
# rubocop: enable
