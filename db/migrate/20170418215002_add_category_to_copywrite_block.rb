class AddCategoryToCopywriteBlock < ActiveRecord::Migration[5.0]
  def change
    add_column :copywrite_blocks, :category, :string
  end
end
