# frozen_string_literal: true

class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.string :name
      t.integer :length
      t.integer :status
      t.integer :commit_id

      t.timestamps
    end
  end
end
