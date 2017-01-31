class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.belongs_to :category, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
