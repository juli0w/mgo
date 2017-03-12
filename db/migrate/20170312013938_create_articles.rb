class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :company
      t.string :slug
      t.string :title
      t.text :content
      t.string :description
      t.string :cover

      t.timestamps
    end
  end
end
