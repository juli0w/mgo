class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :tag
      t.belongs_to :company

      t.timestamps
    end
  end
end
