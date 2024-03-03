# frozen_string_literal: true

require 'rails_helper'

describe ResetPasswordMailer do
  subject { described_class.send_new_password(user, new_password) }
  context 'send new password' do
    before do
      stub_const(
        'ENV', {
          'GMAIL_EMAIL' => 'rustem.sadboy@gmail.com',
          'JWT_SECRET_KEY' => 'secret'
        }
      )
    end

    let(:user) { create(:user) }
    let(:new_password) { 'bebrails' }

    it 'renders the subject' do
      expect(subject.subject).to eq 'New Password'
    end

    it 'renders the receiver email' do
      expect(subject.to).to eq [user.email]
    end

    it 'renders the sender email' do
      expect(subject.from).to eq [ENV.fetch('GMAIL_EMAIL')]
    end

    it 'assigns @user.revocery_password' do
      expect(subject.body.encoded).to match(new_password)
    end

    it 'assigns @user.revocery_password' do
      expect(subject.body.encoded).to match(new_password)
    end
  end
end
