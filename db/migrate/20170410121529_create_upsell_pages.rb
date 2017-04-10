class CreateUpsellPages < ActiveRecord::Migration[5.0]
  def change
    create_table :upsell_pages do |t|
      t.string :image
      t.string :content
      t.string :link
      t.string :link_call

      t.timestamps
    end
  end
end
