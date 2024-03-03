# frozen_string_literal: true

module Audios
  class Create < ::ApplicationService
    param :params
    option :contract, default: -> { ::Audios::CreateForm }

    def call
      valid_params = yield validate_contract(contract, params)
      audio = Db.transaction do
        audio = Audio.create!
        audio.audio_attach(valid_params[:audio_file])

        audio
      end

      Success(audio)
    end
  end
end
