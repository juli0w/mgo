class CreateFonts < ActiveRecord::Migration[5.0]
  def change
    create_table :fonts do |t|
      t.string :name
      t.string :url

      t.timestamps
    end

    change_table :profiles do |t|
      t.references :font, foreign_key: true
    end

    Font.seed!
  end
end
