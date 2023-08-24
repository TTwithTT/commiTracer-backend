# frozen_string_literal: true

class CreateStickyNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :sticky_notes do |t|
      t.string :reflection
      t.integer :commit_id

      t.timestamps
    end
  end
end
