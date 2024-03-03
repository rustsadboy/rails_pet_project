# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sessions::Create do
  subject { described_class.call(data) }

  let!(:user) { create(:user, :with_recovery, email:, password:) }
  let(:email) { 'bebra@mail.ru' }
  let(:password) { 'supersecret' }
  let(:data) { { email:, password: } }

  context 'successful session create' do
    context 'session by default password' do
      it 'session created' do
        result = subject.value!
        expect(result[:user]).to eq user
        expect(result[:token]).not_to be_nil
      end
    end
  end

  context 'is failure' do
    context 'email not found' do
      let(:another_email) { 'monada@mail.ru' }
      let(:data) { { email: another_email, password: } }

      it 'user created' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'incorrect password' do
      let(:another_password) { 'no_batches?' }
      let(:data) { { email:, password: another_password } }

      it 'user created' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::UnauthorizedError
      end
    end
  end
end
