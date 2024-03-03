# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    skip_before_action :validate_token, only: :create

    def create
      result = ::Sessions::Create.(params)

      result.either(
        lambda { |success_data|
          response.headers['Authorization'] = success_data[:token]
          render_blueprint(success_data[:user], ::Users::EmailsBlueprint, options: { view: :authorization })
        },
        ->(failure_obj) { render_failure(failure_obj) }
      )
    end
  end
end
