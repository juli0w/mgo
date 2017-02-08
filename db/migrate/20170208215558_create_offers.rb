class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.string :name
      t.string :short_name
      t.string :category_name
      t.decimal :price_from
      t.decimal :price
      t.string :thumbnail
      t.string :link

      t.timestamps
    end
  end
end
