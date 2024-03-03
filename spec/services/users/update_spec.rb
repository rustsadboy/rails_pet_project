# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Update do
  include ActiveJob::TestHelper
  subject { described_class.call(user, params) }

  let(:user) { create(:user, password: 'heil_snail_1488', email_confirmed: true) }
  let(:freeze_time) { Time.utc(2020, 8, 30, 19, 0, 20) }

  before do
    travel_to freeze_time
  end

  after do
    travel_back
  end

  context 'with valid params' do
    let(:params) do
      {
        name: 'abobus amigus',
        email: 'snail_lover1243@gmail.com',
        old_password: 'heil_snail_1488',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    it 'updates user' do
      subject
      user.reload
      expect(user.name).to eq params[:name]
      expect(user.email).to eq params[:email]
      expect(user.authenticate(params[:password])).to eq user
      expect(user.last_sent_confirmation_at).to eq freeze_time
      expect(user.email_confirmed).to eq false
      assert_enqueued_with(job: EmailConfirmationMailer.delivery_job, queue: 'mailers')
    end
  end

  context 'with non-confirmed email and nullable last_sent_confirmation_at' do
    let(:params) do
      {
        name: 'abobus amigus',
        old_password: 'heil_snail_1488',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    let(:user) { create(:user, password: 'heil_snail_1488', email_confirmed: false, last_sent_confirmation_at: nil) }

    it 'updates user' do
      subject
      user.reload
      expect(user.name).to eq params[:name]
      expect(user.authenticate(params[:password])).to eq user
      expect(user.last_sent_confirmation_at).to eq freeze_time
      expect(user.email_confirmed).to eq false
      assert_enqueued_with(job: EmailConfirmationMailer.delivery_job, queue: 'mailers')
    end
  end

  context 'with non-confirmed email and outdated last_sent_confirmation_at' do
    let(:params) do
      {
        name: 'abobus amigus',
        old_password: 'heil_snail_1488',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    let(:user) { create(:user, password: 'heil_snail_1488', email_confirmed: false, last_sent_confirmation_at: 11.minutes.ago) }

    it 'updates user' do
      subject
      user.reload
      expect(user.name).to eq params[:name]
      expect(user.authenticate(params[:password])).to eq user
      expect(user.last_sent_confirmation_at).to eq freeze_time
      expect(user.email_confirmed).to eq false
      assert_enqueued_with(job: EmailConfirmationMailer.delivery_job, queue: 'mailers')
    end
  end

  context 'with non-confirmed email' do
    let(:params) do
      {
        name: 'abobus amigus',
        old_password: 'heil_snail_1488',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    let(:last_sent_confirmation_at) { 2.minutes.ago }
    let(:user) { create(:user, password: 'heil_snail_1488', email_confirmed: false, last_sent_confirmation_at:) }

    it 'updates user' do
      subject
      user.reload
      expect(user.name).to eq params[:name]
      expect(user.authenticate(params[:password])).to eq user
      expect(user.last_sent_confirmation_at).to eq last_sent_confirmation_at
      expect(user.email_confirmed).to eq false
      assert_no_enqueued_jobs
    end
  end

  context 'with invalid old password' do
    let(:params) do
      {
        old_password: 'heil_snail_228',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    it 'does not updates user' do
      expect(subject.failure?).to eq true
      expect(subject.failure).to be_a Api::UnprocessableEntityError
      expect(user.reload.authenticate(params[:password])).to eq false
    end
  end

  context 'with invalid password confirmation' do
    let(:params) do
      {
        old_password: 'heil_snail_1488',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_228'
      }
    end

    it 'does not updates user' do
      subject
      user.reload
      expect(user.authenticate(params[:password])).to eq false
    end
  end

  context 'without email and with email param' do
    let!(:user) { create(:user, email: nil) }

    let(:params) do
      {
        email: 'new_email@mail.ru'
      }
    end

    it 'raise error' do
      expect(subject.failure?).to eq true
      expect(subject.failure).to be_a Api::UnprocessableEntityError
      expect(user.reload.email).to be_nil
    end
  end

  context 'without email and with password param' do
    let!(:user) { create(:user, email: nil, password: nil) }

    let(:params) do
      {
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    it 'raise error' do
      expect(subject.failure?).to eq true
      expect(subject.failure).to be_a Api::UnprocessableEntityError
      expect(user.reload.authenticate(params[:password])).to eq false
    end
  end

  context 'without old password param' do
    let(:params) do
      {
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    it 'raise error' do
      expect(subject.failure?).to eq true
      expect(subject.failure).to be_a Api::UnprocessableEntityError
      expect(user.reload.authenticate(params[:password])).to eq false
    end
  end

  context 'without password and without old_password param' do
    let!(:user) { create(:user, password: nil) }

    let(:params) do
      {
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    it 'raise error' do
      expect(subject.success?).to eq true
      expect(user.reload.authenticate(params[:password])).to eq user
    end
  end

  context 'without password and with old_password param' do
    let!(:user) { create(:user, password: nil) }

    let(:params) do
      {
        old_password: 'heil_snail_228',
        password: 'heil_snail_1387',
        password_confirmation: 'heil_snail_1387'
      }
    end

    it 'raise error' do
      expect(subject.failure?).to eq true
      expect(subject.failure).to be_a Api::UnprocessableEntityError
      expect(user.reload.authenticate(params[:password])).to eq false
    end
  end
end
