class AddUfToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :uf_id, :integer

    Profile.all.each do |profile|
      profile.uf = "SC" if profile.uf.nil?
      profile.uf_id = Uf.where(name: profile.uf.downcase).first_or_create.id
      profile.save
    end

    remove_column :profiles, :uf
  end
end
