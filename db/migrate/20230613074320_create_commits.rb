class CreateCommits < ActiveRecord::Migration[7.0]
  def change
    create_table :commits do |t|
      t.string :title

      t.timestamps
    end
  end
end
