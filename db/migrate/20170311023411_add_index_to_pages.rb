class AddIndexToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :index, :integer, default: 1
  end
end
