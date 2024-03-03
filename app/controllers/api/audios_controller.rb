# frozen_string_literal: true

module Api
  class AudiosController < ApplicationController
    authorize_with! do
      ::Users::Completed.(current_user)
    end

    def create
      render_result(::Audios::Create.(params), blueprint: ::AudiosBlueprint, status: :created)
    end
  end
end
