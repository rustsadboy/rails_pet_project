# frozen_string_literal: true

module Users
  class EmailsBlueprint < Blueprinter::Base
    identifier :id
    field :email_confirmed

    view :registration do
      fields :registration_completed
    end

    view :authorization do
      include_view :registration
    end

    view :oauth_registration do
      include_view :registration
      exclude :email_confirmed
      field :name
    end
  end
end
