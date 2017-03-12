class CreateBlogPages < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_pages do |t|
      t.integer :max, default: 4

      t.timestamps
    end
  end
end
