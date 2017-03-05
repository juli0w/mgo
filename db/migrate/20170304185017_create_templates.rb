class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.references :profile, foreign_key: true
      t.integer :primary_color_id
      t.integer :detail_color_id
      t.integer :link_color_id
      t.integer :text_color_id
      t.integer :logo_color_id
      t.integer :description_color_id

      t.timestamps
    end
  end
end
