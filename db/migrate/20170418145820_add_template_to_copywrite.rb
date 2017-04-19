class AddTemplateToCopywrite < ActiveRecord::Migration[5.0]
  def change
    add_column :copywrites, :template, :text
  end
end
