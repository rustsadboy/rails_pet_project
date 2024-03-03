# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Emails::Create do
  include ActiveJob::TestHelper

  subject { described_class.call(data) }

  let(:email) { 'bebra@mail.ru' }
  let(:name) { 'mrBebra' }
  let(:password) { 'supersecret' }
  let(:data) { { email:, name:, password: } }

  context 'user created and email sended' do
    let(:freeze_time) { Time.utc(2020, 8, 30, 19, 0, 20) }

    before do
      travel_to freeze_time
    end

    after do
      travel_back
    end

    it 'user created' do
      result = subject.value!
      user = User.last
      expect(result[:user]).to eq user
      expect(result[:token]).not_to be_nil
      expect(user.email).to eq email
      expect(user.name).to eq name
      expect(user.email_confirmed).to be_falsey
      expect(user.registration_completed).to be_falsey
      expect(user.last_sent_confirmation_at).to eq freeze_time
      assert_enqueued_with(job: EmailConfirmationMailer.delivery_job, queue: 'mailers')
    end
  end

  context 'is failure' do
    let(:email) { 1 }
    let(:name) { 1 }

    it 'user created' do
      result = subject
      expect(result.failure?).to eq true
      expect(result.failure).to be_a Api::UnprocessableEntityError
    end
  end
end
