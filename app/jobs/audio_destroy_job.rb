# frozen_string_literal: true

class AudioDestroyJob < ApplicationJob
  sidekiq_options queue: :audio_destroy

  def perform
    Audio.not_related?.where(created_at: [..1.day.ago]).destroy_all
  end
end
