# frozen_string_literal: true

module Api
  module Users
    class EmailsController < ApplicationController
      skip_before_action :validate_token

      def create
        result = ::Users::Emails::Create.(params)

        result.either(
          lambda { |success_data|
            response.headers['Authorization'] = success_data[:token]

            render_blueprint(
              success_data[:user],
              ::Users::EmailsBlueprint,
              options: { view: :registration }
            )
          },
          ->(failure_obj) { render_failure(failure_obj) }
        )
      end
    end
  end
end
