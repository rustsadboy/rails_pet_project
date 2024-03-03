# frozen_string_literal: true

module Audios
  class CreateForm < ApplicationForm
    params do
      required(:audio_file)
    end

    rule(:audio_file).validate(:valid_audio_file)
  end
end
