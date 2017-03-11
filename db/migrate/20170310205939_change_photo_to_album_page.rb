class ChangePhotoToAlbumPage < ActiveRecord::Migration[5.0]
  def change
    rename_column :photos, :album_id, :album_page_id
  end
end
