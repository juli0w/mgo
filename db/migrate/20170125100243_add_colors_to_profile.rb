class AddColorsToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :primary_color, :string
    add_column :profiles, :detail_color, :string
    add_column :profiles, :link_color, :string
    add_column :profiles, :text_color, :string
    add_column :profiles, :logo_color, :string
    add_column :profiles, :description_color, :string
    add_column :profiles, :cover, :string
  end
end
