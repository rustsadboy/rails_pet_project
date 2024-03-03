# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:relation) { Relationship.create!(follower_id: user.id, followed_id: user1.id) }

  it 'raise error without follower_id' do
    subject.followed_id = user1.id
    expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'raise error without followed_id' do
    subject.follower_id = user.id
    expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'raise error with follower_id and followed_id that already exists' do
    subject.follower_id = user.id
    subject.followed_id = user1.id
    expect { subject.save! }.to raise_error ActiveRecord::RecordNotUnique
  end

  it 'create successfully with new follower_id and followed_id' do
    subject.follower_id = user.id
    subject.followed_id = user2.id
    expect { subject.save! }.not_to raise_error
    expect(subject.valid?).to eq true
  end
end
