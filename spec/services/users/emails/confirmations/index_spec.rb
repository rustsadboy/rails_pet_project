# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Emails::Confirmations::Index do
  include ActiveJob::TestHelper

  subject { described_class.call(data) }

  let(:user) do
    create(
      :user,
      email: 'abobebrus@snail.ru',
      email_confirmed: false,
      registration_token: CodeHelper.generate_registration_token
    )
  end
  let(:token) do
    CodeHelper.generate_confirmation_token(
      user.email,
      user.registration_token
    )
  end
  let(:data) { { token: } }

  context 'email confirmed for user' do
    it 'email confirmed' do
      subject
      user.reload
      expect(user.email_confirmed).to eq true
      expect(user.registration_token).to be_nil
    end
  end

  context 'failure' do
    context 'invalid registration token ' do
      let(:token) do
        CodeHelper.generate_confirmation_token(user.email, 'asdasdasd')
      end

      it 'return failure' do
        result = subject
        expect(result.failure?).to eq true
        expect(result.failure).to be_a Api::UnprocessableEntityError
      end
    end

    context 'invalid token format' do
      let(:token) { 'jopa' }

      it 'raise error' do
        expect { subject }.to raise_error Api::UnauthorizedError
      end
    end

    context 'email not found' do
      let(:token) do
        CodeHelper.generate_confirmation_token('abobing@snail.ru', 'asdasdasd')
      end

      it 'raise error' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
