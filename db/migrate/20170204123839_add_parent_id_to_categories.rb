class AddParentIdToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :ancestor_id, :integer
  end
end