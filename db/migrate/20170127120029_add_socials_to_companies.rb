class AddSocialsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :facebook, :string
    add_column :companies, :instagram, :string
    add_column :companies, :twitter, :string
  end
end
