class AddRuleToFonts < ActiveRecord::Migration[5.0]
  def change
    add_column :fonts, :rule, :string, default: "serif"
  end
end
