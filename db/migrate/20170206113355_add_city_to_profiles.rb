class AddCityToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :city_id, :integer

    # Profile.all.each do |profile|
    #   profile.city = "Joinville" if profile.city.nil?
    #   profile.city_id = City.where(name: profile.city.downcase).first_or_create.id
    #   profile.save
    # end

    remove_column :profiles, :city
  end
end
