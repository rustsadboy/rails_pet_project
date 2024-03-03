# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationships::Index do
  subject { described_class.call(params, relationship) }

  let(:user) { create(:user) }
  let(:user1) { create(:user, name: 'snail', email: 'email1@mail.ru') }
  let(:user2) { create(:user, name: 'aaasnail', email: 'email2@mail.ru') }
  let(:user3) { create(:user, name: 'lizard', email: 'email@snail.ru') }
  let(:user4) { create(:user, name: 'kukareko', email: 'email3@mail.ru') }

  context 'with followings' do
    let(:relationship) { :followings }
    let(:params) { { user_id: user.id } }

    before do
      create(:relationship, follower: user, followed: user1)
      create(:relationship, follower: user, followed: user2)
      create(:relationship, follower: user, followed: user3)
      create(:relationship, follower: user, followed: user4)
    end

    it 'should receive followings' do
      result = subject.value!
      expect(result[:relation_count]).to eq 4
      expect(result[:relation][0]).to eq user4
      expect(result[:relation][1]).to eq user3
      expect(result[:relation][2]).to eq user2
      expect(result[:relation][3]).to eq user1
    end
  end

  context 'with followers' do
    let(:relationship) { :followers }
    let(:params) { { user_id: user.id } }

    before do
      create(:relationship, followed: user, follower: user1)
      create(:relationship, followed: user, follower: user2)
      create(:relationship, followed: user, follower: user3)
      create(:relationship, followed: user, follower: user4)
    end

    it 'should receive followers' do
      result = subject.value!
      expect(result[:relation_count]).to eq 4
      expect(result[:relation][0]).to eq user4
      expect(result[:relation][1]).to eq user3
      expect(result[:relation][2]).to eq user2
      expect(result[:relation][3]).to eq user1
    end
  end

  context 'with pagination' do
    let(:relationship) { :followers }
    let(:params) { { user_id: user.id, page: 2, limit: 2 } }

    before do
      create(:relationship, followed: user, follower: user1)
      create(:relationship, followed: user, follower: user2)
      create(:relationship, followed: user, follower: user3)
      create(:relationship, followed: user, follower: user4)
    end

    it 'should receive followers' do
      result = subject.value!
      expect(result[:relation_count]).to eq 4
      expect(result[:relation][0]).to eq user2
      expect(result[:relation][1]).to eq user1
    end
  end

  context 'with search query' do
    let(:relationship) { :followers }
    let(:params) { { user_id: user.id, query: 'snail' } }

    before do
      create(:relationship, followed: user, follower: user1)
      create(:relationship, followed: user, follower: user2)
      create(:relationship, followed: user, follower: user3)
      create(:relationship, followed: user, follower: user4)
    end

    it 'should receive followers with query' do
      result = subject.value!
      expect(result[:relation_count]).to eq 4
      expect(result[:relation].count).to eq 2
      expect(result[:relation][0]).to eq user2
      expect(result[:relation][1]).to eq user1
    end
  end
end
