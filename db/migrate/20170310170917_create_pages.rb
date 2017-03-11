class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :pageable_type
      t.integer :pageable_id
      t.string :title
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
