class CreateSampleTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :sample_templates do |t|
      t.string :name

      t.timestamps
    end

    add_column :templates, :sample_template_id, :integer
    add_index  :templates, :sample_template_id
  end
end
