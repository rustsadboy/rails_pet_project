# frozen_string_literal: true

module Users
  class ProfilesBlueprint < Blueprinter::Base
    identifier :id

    view :subs do
      field :name
    end

    view :normal do
      include_view :subs
      fields :followings_count, :followers_count, :search_id
      field :is_followed do |_record, options|
        options[:is_followed]
      end
    end

    view :extended do
      fields :email_confirmed, :password_present, :email, :gender, :age
      include_views :normal
      exclude :is_followed
    end

    view :registered do
      fields :email, :registration_completed, :gender, :age
    end

    view :recovery_password do
      field :recovery_password_expired_at
    end
  end
end
