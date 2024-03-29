# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :registration_token
      t.timestamp :expired_at
      t.string :password_digest, null: false
      t.integer :gender
      t.integer :age

      t.timestamps
    end
  end
end
