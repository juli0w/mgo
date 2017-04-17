class CreateLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :leads do |t|
      t.references :company, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
