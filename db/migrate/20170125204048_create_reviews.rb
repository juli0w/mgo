class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :comment
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
