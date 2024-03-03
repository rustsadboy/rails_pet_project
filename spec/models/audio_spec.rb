# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Audio, type: :model do
  subject { described_class.new }
  it { is_expected.to have_one_attached(:audio_file) }

  context 'with audio_file' do
    let(:audio_file) do
      Rack::Test::UploadedFile.new(
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'audios', 'piano.mid'))
      )
    end

    it 'attach successfully audio_file' do
      subject.save!
      expect { subject.audio_attach(audio_file) }.not_to raise_error
      expect(subject.reload.audio_file.attached?).to eq true
      expect(subject.audio_file_url).not_to be_nil
    end
  end

  context 'without audio_file' do
    it 'should get empty url audio_file' do
      subject.save!
      expect(subject.audio_file_url).to be_nil
    end
  end
end
