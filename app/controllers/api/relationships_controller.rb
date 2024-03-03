# frozen_string_literal: true

module Api
  class RelationshipsController < ApplicationController
    authorize_with! do
      ::Users::Completed.(current_user)
    end

    def create
      render_result(::Relationships::Create.(current_user, params))
    end

    def destroy
      render_result(::Relationships::Destroy.(current_user, params))
    end
  end
end
