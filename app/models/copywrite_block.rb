class CopywriteBlock < ApplicationRecord
  has_many :copywritings

  include SearchCop
  search_scope :search do
    attributes :name, :template
  end

  CATEGORIES = %w(Atenção Conexão Problema Solução Fechamento)

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      block = find_by_name(row["name"]) || new
      block.attributes = row.to_hash
      block.save!
    end
  end
end
