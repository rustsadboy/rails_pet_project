# frozen_string_literal: true

module Api
  class OauthsController < ApplicationController
    skip_before_action :validate_token

    def create
      result = ::Oauths::Create.(params)

      result.either(
        lambda { |success_data|
          response.headers['Authorization'] = success_data[:token]
          render_blueprint(success_data[:user], ::Users::EmailsBlueprint, options: { view: :oauth_registration })
        },
        ->(failure_obj) { render_failure(failure_obj) }
      )
    end
  end
end
