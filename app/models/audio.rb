# frozen_string_literal: true

class Audio < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :audio_file

  AUDIO_FILE_TYPES = %w[midi mid mp3 mpeg wav].freeze
  EXCLUDED_ASSOCIATIONS = %i[audio_file_blob audio_file_attachment].freeze

  def audio_attach(file)
    io_file = File.open(file)
    filename = io_file.is_a?(File) ? File.basename(file, File.extname(file)) : file.original_filename
    audio_file.attach(io: io_file, filename:, content_type: "audio/#{File.extname(io_file)[1..]}")
  end

  def audio_file_url
    url_for(audio_file) if audio_file.attached?
  end

  def related?
    self.class.not_related?.pluck(:id).exclude?(id)
  end

  def self.not_related?
    associations = reflect_on_all_associations.map(&:name) - EXCLUDED_ASSOCIATIONS
    where_clause = associations.to_h do |a|
      ["#{a}.id", nil]
    end

    left_joins(associations).where(where_clause)
  end
end
