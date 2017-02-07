class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.references :company, foreign_key: true
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
