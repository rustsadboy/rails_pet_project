# frozen_string_literal: true

class AddEmailConfirmedAndRegistrationCompletedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :registration_completed, :boolean, null: false, default: false
    add_column :users, :email_confirmed, :boolean, null: false, default: false
  end
end
