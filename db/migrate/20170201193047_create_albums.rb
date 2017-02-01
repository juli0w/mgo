class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.column :photos, :json
      t.references :company
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
