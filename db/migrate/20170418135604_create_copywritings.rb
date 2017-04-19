class CreateCopywritings < ActiveRecord::Migration[5.0]
  def change
    create_table :copywritings do |t|
      t.references :copywrite, foreign_key: true
      t.references :copywrite_block, foreign_key: true

      t.timestamps
    end
  end
end
