class RemoveIndexFromBlocks < ActiveRecord::Migration[7.0]
  def change
    remove_column :blocks, :index
  end
end
