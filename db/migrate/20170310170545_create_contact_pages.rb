class CreateContactPages < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_pages do |t|
      t.string :email

      t.timestamps
    end
  end
end
