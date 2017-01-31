class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :company, foreign_key: true
      t.text :institutional
      t.string :phone
      t.string :mail
      t.string :city
      t.string :uf
      t.string :address

      t.timestamps
    end
  end
end
