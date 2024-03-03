# frozen_string_literal: true

module Api
  class RecoveryPasswordsController < BaseController
    def create
      result = RecoveryPasswords::Create.(params)

      render_result(
        result,
        blueprint: ::Users::ProfilesBlueprint,
        options: { view: :recovery_password }
      )
    end

    def index
      result = RecoveryPasswords::Index.(params)

      render_template result, title: 'New Password Sended'
    end
  end
end
