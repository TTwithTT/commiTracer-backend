class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.integer :index
      t.string :name
      t.integer :length
      t.integer :status

      t.timestamps
    end
  end
end
