class CreateLandingPages < ActiveRecord::Migration[5.0]
  def change
    create_table :landing_pages do |t|
      t.string :image
      t.text :content
      t.text :details
      t.string :link_call
      t.string :link

      t.timestamps
    end
  end
end
