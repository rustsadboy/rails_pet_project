# frozen_string_literal: true

module Users
  class CreateForm < ApplicationForm
    params do
      required(:gender).value(:string, included_in?: User.genders)
      required(:age).value(:string, included_in?: User.ages)
    end
  end
end
