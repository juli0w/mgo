class AddFieldsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :code, :string
    add_column :companies, :lat, :string
    add_column :companies, :lng, :string
  end
end
