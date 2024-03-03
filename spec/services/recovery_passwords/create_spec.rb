# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecoveryPasswords::Create do
  include ActiveJob::TestHelper

  subject { described_class.call(data) }
  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:data) { { email: } }

  before do
    stub_const('ENV', { 'RECOVERY_EXPIRED_TIME' => '1', 'GMAIL_EMAIL' => 'rustem.sadboy@gmail.com' })
  end

  context 'recovery created and email sended' do
    let(:freeze_time) { Time.utc(2020, 8, 30, 19, 0, 20) }

    before do
      travel_to freeze_time
    end

    after do
      travel_back
    end

    it 'revocery created' do
      user = subject.value!
      expect(user.recovery_password_expired_at).to eq DateTime.now + 1.hour
      assert_enqueued_with(job: SubmitRecoveryPasswordMailer.delivery_job, queue: 'mailers')
    end
  end

  context 'is failure' do
    context 'email not found' do
      let(:email) { 'notfound@bebr.com' }

      it 'raise error' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'invalid email format' do
      let(:email) { 1 }

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::UnprocessableEntityError
      end
    end

    context 'recovery already created' do
      let(:user) { create(:user, :with_recovery) }

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::UnprocessableEntityError
      end
    end

    context 'email not confirmed' do
      let(:user) { create(:user, email_confirmed: false) }

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::AccessForbiddenError
      end
    end

    context 'password not present' do
      let(:user) { create(:user, password: nil) }

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::AccessForbiddenError
      end
    end
  end
end
