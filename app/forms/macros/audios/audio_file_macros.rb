# frozen_string_literal: true

module Macros
  module Audios
    module AudioFileMacros
      extend ActiveSupport::Concern

      included do
        register_macro(:valid_audio_file) do |_macro:|
          if value.present? && Audio::AUDIO_FILE_TYPES.exclude?(File.extname(value)[1..])
            key.failure(I18n.t('api.errors.messages.invalid_audio_type'))
          end
        end
      end
    end
  end
end
