class AddLogotipoToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :logotipo, :string
  end
end
