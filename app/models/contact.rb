class Contact < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  # validates :destination, presence: true

  belongs_to :company, optional: true

  def deliver
    if save
      ContactMailer.contact_email(self).deliver_now  unless self.destination.empty?
      return true
    else
      return false
    end
  end
end
