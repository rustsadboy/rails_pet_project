# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/audios', type: :request do
  path '/api/audios' do
    post 'Create audio' do
      tags 'Audios'

      consumes 'multipart/form-data'
      produces 'application/json'

      include_context :with_authenticated_user

      parameter in: :body, schema: {
        type: :object,
        properties: {
          audio_file: { type: :file, description: 'Audio file', required: true }
        }
      }

      response '201', 'audio created' do
        schema '$ref': '#/components/schemas/audio'

        before do
          allow_any_instance_of(Rswag::Specs::ResponseValidator).to receive(:validate!).and_return(true)
        end

        run_test!
      end

      response '422', 'params error' do
        include_examples 'with error response 422', I18n.t('dry_validation.errors.key?.failure')
      end

      include_context :with_response_unauthorized
      include_context :with_response_user_not_completed
    end
  end

  context 'with valid params' do
    let(:user) { create(:user) }
    let(:token) { JsonWebToken.encode({ user_id: user.id }) }
    let(:params) do
      {
        audio_file: Rack::Test::UploadedFile.new(
          Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'audios', 'piano.mid'))
        )
      }
    end

    it 'creates audio' do
      expect { post('/api/audios', params:, headers: { Authorization: token }) }.to change(Audio, :count).by(1)
      expect(response.status).to eq 201
    end
  end

  context 'with invalid params' do
    let(:user) { create(:user) }
    let(:token) { JsonWebToken.encode({ user_id: user.id }) }
    let(:params) do
      {
        audio_file: Rack::Test::UploadedFile.new(
          Rack::Test::UploadedFile.new(Rails.root.join('spec', 'factories', 'images', 'test_image.png'))
        )
      }
    end

    it 'does not create audio' do
      expect { post('/api/audios', params:, headers: { Authorization: token }) }.not_to change(Audio, :count)
      expect(response.status).to eq 422
    end
  end

  context 'unauthorized error' do
    let(:params) { { audio_file: 'wrong_file_type' } }

    it 'does not create audio' do
      expect { post('/api/audios', params:) }.not_to change(Audio, :count)
      expect(response.status).to eq 401
    end
  end
end
