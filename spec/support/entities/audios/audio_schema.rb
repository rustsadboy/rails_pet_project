# frozen_string_literal: true

module Entities
  module Audios
    AUDIO_SCHEMA = {
      type: :object,
      properties: {
        id: { type: :integer, example: 1, required: true },
        url: { type: :string, example: 'url' }
      }
    }.freeze
  end
end
