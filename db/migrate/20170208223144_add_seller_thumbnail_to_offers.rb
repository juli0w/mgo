class AddSellerThumbnailToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :seller_thumbnail, :string
  end
end
