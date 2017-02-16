class AlterTableSubscribes < ActiveRecord::Migration[5.0]
  def change
    remove_column :subscribes, :name, :string
    remove_column :subscribes, :email, :string
    add_column :subscribes, :user_id, :integer
    add_column :subscribes, :company_id, :integer
    add_column :subscribes, :state, :integer, default: 0
    add_column :subscribes, :paid_at, :datetime
    add_column :subscribes, :price, :decimal
  end
end
