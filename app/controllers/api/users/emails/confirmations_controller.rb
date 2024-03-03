# frozen_string_literal: true

module Api
  module Users
    module Emails
      class ConfirmationsController < BaseController
        def index
          result = ::Users::Emails::Confirmations::Index.(params)

          render_template result, title: 'Email Confirmation'
        end
      end
    end
  end
end
