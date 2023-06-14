class AddCommitIdToBlocks < ActiveRecord::Migration[7.0]
  def change
    add_column :blocks, :commit_id, :integer
  end
end
