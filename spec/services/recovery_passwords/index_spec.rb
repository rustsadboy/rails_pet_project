# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecoveryPasswords::Index do
  include ActiveJob::TestHelper

  subject { described_class.call(data) }
  let(:user) { create(:user, :with_recovery) }
  let(:token) do
    CodeHelper.generate_recovery_token(
      user.email,
      user.recovery_password_expired_at
    )
  end
  let(:data) { { token: } }

  before do
    stub_const(
      'ENV', {
        'GMAIL_EMAIL' => 'rustem.sadboy@gmail.com',
        'JWT_SECRET_KEY' => 'secret',
        'RECOVERY_EXPIRED_TIME' => '1'
      }
    )
  end

  context 'password updated and email with new pass sended' do
    it 'new password created' do
      subject
      expect(user.reload.recovery_password_expired_at).to be_nil
      assert_enqueued_with(job: ResetPasswordMailer.delivery_job, queue: 'mailers')
    end
  end

  context 'is failure' do
    context 'invalid token format' do
      let(:token) { 'bebrails' }

      it 'raise error' do
        expect { subject }.to raise_error Api::UnauthorizedError
      end
    end

    context 'email not found' do
      let(:token) do
        CodeHelper.generate_recovery_token(
          'bebrails@mail.ru',
          user.recovery_password_expired_at
        )
      end

      it 'raise error' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'token outdated' do
      let(:user) { create(:user, recovery_password_expired_at: DateTime.now - 2.hours) }

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

    context 'password is blank' do
      let(:user) { create(:user, password: nil) }

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::AccessForbiddenError
      end
    end
  end
end
