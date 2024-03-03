# frozen_string_literal: true

require 'rails_helper'

describe SubmitRecoveryPasswordMailer do
  subject { described_class.send_submit(user) }
  context 'send confirmation' do
    before do
      stub_const(
        'ENV', {
          'GMAIL_EMAIL' => 'rustem.sadboy@gmail.com',
          'JWT_SECRET_KEY' => 'secret'
        }
      )
    end

    let(:user) { create(:user) }

    it 'renders the subject' do
      expect(subject.subject).to eq 'Password Recovery Submit'
    end

    it 'renders the receiver email' do
      expect(subject.to).to eq [user.email]
    end

    it 'renders the sender email' do
      expect(subject.from).to eq [ENV.fetch('GMAIL_EMAIL')]
    end

    it 'assigns @user.revocery_password' do
      expect(subject.body.encoded).to match('token')
    end
  end
end
