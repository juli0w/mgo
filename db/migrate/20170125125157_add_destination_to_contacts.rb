class AddDestinationToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :destination, :string
  end
end
