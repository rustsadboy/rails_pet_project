# frozen_string_literal: true

class CreateAudios < ActiveRecord::Migration[7.0]
  def change
    create_table :audios do |t|
      t.timestamps
    end
  end
end
