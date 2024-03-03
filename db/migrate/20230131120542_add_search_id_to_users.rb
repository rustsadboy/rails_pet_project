# frozen_string_literal: true

class AddSearchIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :search_id, :integer
    add_index :users, :search_id, unique: true
  end
end
