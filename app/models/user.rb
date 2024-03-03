# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :user_oauths, dependent: :destroy

  enum gender: %i[male female].freeze
  enum age: %i[under16 16-19 20-25 26-30 31-35 36-40 over40].freeze

  GENDERS = genders.keys.freeze
  AGES = ages.keys.freeze

  def follow(user)
    followings << user
  end

  def unfollow(user)
    followings.delete(user)
  end

  def following?(user)
    followings.include?(user)
  end

  def mark_activity!
    update!(last_active_at: DateTime.now)
  end

  def password_present
    password_digest.present?
  end
end
