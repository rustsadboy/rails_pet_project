# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationships::Destroy do
  subject { described_class.call(user, params) }

  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let!(:relationship) { create(:relationship, follower_id: user.id, followed_id: user1.id) }

  context 'with valid params' do
    let(:params) { { followed_id: user1.id } }

    it 'unfollow user' do
      expect(subject.success?).to eq true
      expect(subject.value![0]).to eq user1
      expect(user.followings.count).to eq 0
    end
  end

  context 'with invalid params' do
    let(:params) { { followed_id: 'sobaka' } }

    it 'fails' do
      expect(subject.failure?).to eq true
      expect(subject.failure.error_hash[:detail]).to eq I18n.t('dry_validation.errors.int?.failure')
    end
  end

  context 'with non-existent id' do
    let(:params) { { followed_id: user.id - 1 } }

    it 'fails' do
      expect { subject }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
