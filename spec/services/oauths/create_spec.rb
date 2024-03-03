# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Oauths::Create do
  subject { described_class.(params) }

  let(:access_token) { 'token' }
  let(:provider) { 'google' }

  before do
    mock_request = instance_double(Oauths::Google::Client)
    allow(Oauths::Google::Client).to receive(:new).with({ access_token: }).and_return(mock_request)
    allow(mock_request).to receive(:call).and_return('1111')
  end

  context 'with new user' do
    let(:params) { { access_token:, provider: } }

    it 'user created' do
      expect(subject.value![:user]).to eq User.last
      expect(User.last.user_oauths.first.uid).to eq '1111'
      expect(User.last.user_oauths.first.provider).to eq provider
      expect(User.last.name).to eq 'Friend'
      expect(User.last.email).to be_nil
      expect(User.last.registration_completed).to eq false
      expect(User.last.email_confirmed).to eq true
    end
  end

  context 'with new user and given email and name' do
    let(:params) { { access_token:, provider:, email: 'test@mail.ru', name: 'PubGay' } }

    it 'user created' do
      expect(subject.value![:user]).to eq User.last
      expect(User.last.user_oauths.first.uid).to eq '1111'
      expect(User.last.user_oauths.first.provider).to eq provider
      expect(User.last.name).to eq params[:name]
      expect(User.last.email).to eq params[:email]
      expect(User.last.registration_completed).to eq false
      expect(User.last.email_confirmed).to eq true
    end
  end

  context 'with completed user' do
    let(:user) { create(:user) }
    let!(:user_oauth) { create(:user_oauth, :google, uid: '1111', user:) }

    let(:params) { { access_token:, provider: } }

    it 'user found' do
      expect(subject.value![:user]).to eq user
    end
  end

  context 'with user email' do
    let(:user) { create(:user, email_confirmed: false) }
    let(:params) { { access_token:, provider:, email: user.email } }

    it 'user found' do
      expect(subject.value![:user]).to eq user
      expect(user.reload.email_confirmed).to eq true
    end
  end
end
