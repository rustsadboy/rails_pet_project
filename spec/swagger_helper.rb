# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        securitySchemes: {
          Bearer: {
            description: 'JWT key necessary to use API calls',
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        },
        schemas: {
          profiles: Entities::Users::PROFILES_SCHEMA,
          subs: Entities::Users::SUBS_SCHEMA,
          emails: Entities::Users::Emails::EMAILS_SCHEMA,
          emails_confirmations: Entities::Users::Emails::CONFIRMATIONS_SCHEMA,
          authorization: Entities::Users::Emails::AUTHORIZATION_SCHEMA,
          user_registered: Entities::Users::REGISTERED_SCHEMA,
          recovery_passwords: RecoveryPasswordsSchema::RECOVERY_SCHEMA,
          audio: Entities::Audios::AUDIO_SCHEMA,
          oauths: Entities::Users::Emails::OAUTHS_SCHEMA,
          error_forbidden: Entities::Errors::ERROR_SCHEMA_FORBIDDEN,
          error_not_found: Entities::Errors::ERROR_SCHEMA_NOT_FOUND,
          error_unprocessable_entity: Entities::Errors::ERROR_SCHEMA_UNPROCESSABLE_ENTITY,
          error_unauthorized: Entities::Errors::ERROR_SCHEMA_UNAUTHORIZED,
          error_conflict: Entities::Errors::ERROR_SCHEMA_CONFLICT,
          error_not_acceptable: Entities::Errors::ERROR_SCHEMA_NOT_ACCEPTABLE
        },
        included: {}
      },
      servers: [
        {
          url: ENV.fetch('ROUTES_HOST', 'http://localhost:3000'),
          variables: {
            defaultHost: {
              default: ENV.fetch('ROUTES_HOST', 'http://localhost:3000')
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
