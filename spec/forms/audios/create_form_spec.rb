# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Audios::CreateForm do
  let!(:params) do
    {
      audio_file: Rack::Test::UploadedFile.new(
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'audios', 'piano.mid'))
      )
    }
  end

  it_behaves_like :valid_form

  it_behaves_like :invalid_form, without: :audio_file

  context 'with invalid audio type' do
    let!(:params) do
      {
        audio_file: Rack::Test::UploadedFile.new(
          Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'test_image.png'))
        )
      }
    end

    it_behaves_like :invalid_form
  end
end
