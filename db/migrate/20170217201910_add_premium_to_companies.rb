class AddPremiumToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :premium, :boolean, default: false
  end
end
