class CreateNewsletters < ActiveRecord::Migration[5.0]
  def change
    create_table :newsletters do |t|
      t.references :company, foreign_key: true
      t.boolean :top, default: false
      t.boolean :bottom, default: true
      t.string :message, default: "Receba nossas novidades por email"
      t.string :action, default: "Assine agora!"

      t.timestamps
    end

    add_column :templates, :newsletter_id, :integer
    add_index  :templates, :newsletter_id
  end
end
