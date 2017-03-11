class AddFieldsToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :description, :string
    add_column :pages, :slug, :string
  end
end
