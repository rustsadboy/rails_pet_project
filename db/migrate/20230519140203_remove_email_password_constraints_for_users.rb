# frozen_string_literal: true

class RemoveEmailPasswordConstraintsForUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, true
    change_column_null :users, :password_digest, true
  end
end
