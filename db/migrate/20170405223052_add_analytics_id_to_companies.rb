class AddAnalyticsIdToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :analytics_id, :string
  end
end
