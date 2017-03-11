class ChangePhotoAlbumForeign < ActiveRecord::Migration[5.0]
  def change
    # change_table :photos do |t|
      remove_column :photos, :album_page_id
      add_column :photos, :album_page_id, :integer
    # end
  end
end
