# frozen_string_literal: true

RSpec.shared_examples 'with error response 403' do |message|
  schema '$ref': '#/components/schemas/error_forbidden'
  let(:message) { message }

  run_test! do |response|
    expect(response.status).to eq 403
    expect(response_errors['detail']).to eq(message).or eq I18n.t('api.errors.messages.access_forbidden')
  end
end

RSpec.shared_examples 'with error response 404' do |message|
  schema '$ref': '#/components/schemas/error_not_found'
  let(:message) { message }

  run_test! do |response|
    expect(response.status).to eq 404
    expect(response_errors['detail']).to eq(message).or eq I18n.t('api.errors.messages.record_not_exists')
  end
end

RSpec.shared_examples 'with error response 422' do |message|
  schema '$ref': '#/components/schemas/error_unprocessable_entity'
  let(:message) { message }

  run_test! do |response|
    expect(response.status).to eq 422
    expect(response_errors['detail']).to eq message
  end
end

RSpec.shared_examples 'with error response 401' do |message|
  schema '$ref': '#/components/schemas/error_unauthorized'
  let(:message) { message }

  run_test! do |response|
    expect(response.status).to eq 401
    expect(response_errors['detail']).to eq(message).or eq I18n.t('api.errors.messages.not_logged_in')
  end
end

RSpec.shared_examples 'with error response 409' do |message|
  schema '$ref': '#/components/schemas/error_conflict'
  let(:message) { message }

  run_test! do |response|
    expect(response.status).to eq 409
    expect(response_errors['detail']).to eq(message).or eq I18n.t('api.errors.messages.conflict')
  end
end

RSpec.shared_examples 'with error response 406' do |message|
  schema '$ref': '#/components/schemas/error_not_acceptable'
  let(:message) { message }

  run_test! do |response|
    expect(response.status).to eq 406
    expect(response_errors['detail']).to eq(message).or eq I18n.t('api.errors.messages.not_acceptable')
  end
end
