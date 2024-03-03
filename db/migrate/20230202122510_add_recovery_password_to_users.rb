# frozen_string_literal: true

class AddRecoveryPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :recovery_password_expired_at, :datetime
  end
end
