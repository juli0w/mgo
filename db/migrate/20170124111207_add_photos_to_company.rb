class AddPhotosToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :photos, :json
  end
end
