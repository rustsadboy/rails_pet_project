# frozen_string_literal: true

FactoryBot.define do
  factory :user_oauth do
    user
    uid { FFaker::Code.ean }

    traits_for_enum(:provider, %i[apple google facebook])
  end
end
