class ChangePhotoAlbumForeign < ActiveRecord::Migration[5.0]
  def change
    # change_table :photos do |t|
      remove_foreign_key :photos, name: "photos_on_album_page_id"
    # end
  end
end
