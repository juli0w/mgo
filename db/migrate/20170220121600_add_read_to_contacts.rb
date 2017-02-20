class AddReadToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :read, :boolean, default: false
  end
end
