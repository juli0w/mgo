class ChangeProfileFields < ActiveRecord::Migration[5.0]
  def self.up
    add_column :companies, :phone, :string
    add_column :companies, :mail, :string
    add_column :companies, :city_id, :integer
    add_column :companies, :uf_id, :integer
    add_column :companies, :address, :string

    Company.find_each do |company|
      company.update(phone: company.profile.phone,
                     mail: company.profile.mail,
                     address: company.profile.address,
                     uf_id: company.profile.uf_id,
                     city_id: company.profile.city_id)
    end

    remove_column :profiles, :phone
    remove_column :profiles, :mail
    remove_column :profiles, :city_id
    remove_column :profiles, :uf_id
    remove_column :profiles, :address
  end

  def self.down
    add_column :profiles, :phone, :string
    add_column :profiles, :mail, :string
    add_column :profiles, :city_id, :integer
    add_column :profiles, :uf_id, :integer
    add_column :profiles, :address, :string

    Company.find_each do |company|
      company.profile.update(phone: company.phone,
                             mail: company.mail,
                             address: company.address,
                             uf_id: company.uf_id,
                             city_id: company.city_id)
    end

    remove_column :companies, :phone
    remove_column :companies, :mail
    remove_column :companies, :city_id
    remove_column :companies, :uf_id
    remove_column :companies, :address
  end
end
