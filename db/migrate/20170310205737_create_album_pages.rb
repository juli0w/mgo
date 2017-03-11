class CreateAlbumPages < ActiveRecord::Migration[5.0]
  def change
    create_table :album_pages do |t|

      t.timestamps
    end
  end
end
