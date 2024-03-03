# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def followings_count
    followings.count
  end

  def followers_count
    followers.count
  end
end
