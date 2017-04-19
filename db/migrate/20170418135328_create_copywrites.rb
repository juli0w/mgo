class CreateCopywrites < ActiveRecord::Migration[5.0]
  def change
    create_table :copywrites do |t|
      t.string :name

      t.timestamps
    end
  end
end
