class CreateCopywriteBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :copywrite_blocks do |t|
      t.string :name
      t.text :template

      t.timestamps
    end
  end
end
