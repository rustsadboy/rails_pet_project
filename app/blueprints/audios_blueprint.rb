# frozen_string_literal: true

class AudiosBlueprint < Blueprinter::Base
  identifier :id
  field :audio_file_url, name: :url
end
