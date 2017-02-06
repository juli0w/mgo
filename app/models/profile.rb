class Profile < ApplicationRecord
  belongs_to :company
  # belongs_to :city
  # belongs_to :uf

  mount_uploader :cover, CoverUploader

  def formatted_address
    "#{self.address} - #{self.city.name}/#{self.uf.name}"
  end

  # def city= city
  #   city_id = City.where(name: city).first_or_create.id
  # end
end
