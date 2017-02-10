class Profile < ApplicationRecord
  belongs_to :company
  belongs_to :city, optional: true
  belongs_to :uf, optional: true

  mount_uploader :cover, CoverUploader

  def formatted_address
    "#{self.address} - #{self.city.name.humanize}/#{self.uf.name.upcase}"
  end

  # def city= city
  #   city_id = City.where(name: city).first_or_create.id
  # end
end
