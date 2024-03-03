# frozen_string_literal: true

FactoryBot.define do
  factory :audio do
    trait :with_midi_audio_file do
      after(:build) do |audio|
        path = Rails.root.join('spec', 'factories', 'audios', 'piano.mid')
        audio.audio_file.attach(io: File.open(path), filename: 'piano.mid', content_type: 'audio/mid')
      end
    end
  end
end
