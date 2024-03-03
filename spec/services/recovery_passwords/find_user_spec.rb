# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecoveryPasswords::FindUser do
  subject { described_class.call(email) }
  let(:user) { create(:user) }
  let(:email) { user.email }

  context 'success' do
    it 'users finded' do
      expect(subject.value!).to eq user
    end
  end

  context 'is failure' do
    context 'email not found' do
      let(:email) { 'notfound@bebr.com' }

      it 'raise error' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
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

    context 'password blank' do
      let(:user) { create(:user, password: nil) }

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::AccessForbiddenError
      end
    end
  end
end
