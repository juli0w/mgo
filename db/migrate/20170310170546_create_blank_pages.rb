class CreateBlankPages < ActiveRecord::Migration[5.0]
  def change
    create_table :blank_pages do |t|
      t.text :content

      t.timestamps
    end
  end
end
