class Profile < ApplicationRecord
  belongs_to :company

  mount_uploader :cover, CoverUploader

  def formatted_address
    "#{self.address} - #{self.city}/#{self.uf}"
  end
end
