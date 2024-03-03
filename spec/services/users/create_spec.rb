# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create do
  subject { described_class.call(user, params) }

  let(:user) { create(:user, registration_completed: false) }
  let(:age) { User::AGES.first }
  let(:gender) { User::GENDERS.first }
  let(:params) { { age:, gender: } }

  context 'with valid params' do
    it 'finishes user registration' do
      subject
      user.reload
      expect(user.age).to eq age
      expect(user.gender).to eq gender
      expect(user.registration_completed).to eq true
      expect(user.search_id.digits.count).to eq 5
    end
  end

  context 'with invalid params' do
    let(:gender) { 'apache_helicopter' }

    it 'does not finish user registration' do
      user.reload
      result = subject
      expect(user.registration_completed).to eq false
      expect(result.failure?).to eq true
      expect(result.failure).to be_a Api::UnprocessableEntityError
    end
  end
end
