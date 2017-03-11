class AddLayoutToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :layout, :string, default: 'default'
  end
end
