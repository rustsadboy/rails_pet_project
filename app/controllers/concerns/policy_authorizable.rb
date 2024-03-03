# frozen_string_literal: true

module PolicyAuthorizable
  extend ActiveSupport::Concern

  class_methods do
    def authorize_with!(**options, &)
      before_action(**options) do
        authorized = instance_exec(&)
        raise Api::AccessForbiddenError unless authorized
      end
    end
  end
end
