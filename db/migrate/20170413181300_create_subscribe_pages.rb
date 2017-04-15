class CreateSubscribePages < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribe_pages do |t|
      t.string :link
      t.string :link_call

      t.timestamps
    end
  end
end
