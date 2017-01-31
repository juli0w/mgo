class Contact < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :destination, presence: true

  def deliver
    ContactMailer.contact_email(self).deliver_now
    save
  end
end
