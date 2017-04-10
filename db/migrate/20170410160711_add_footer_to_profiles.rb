class AddFooterToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :footer, :string, default: "default"
  end
end
