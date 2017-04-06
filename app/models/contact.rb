class Contact < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }

  belongs_to :company, optional: true

  def mark_as_read!
    update(read: true)
  end

  include SearchCop
  search_scope :search do
    attributes :name, :email, :phone, :message
  end

  def deliver
    if save
      ContactMailer.contact_email(self).deliver_now  unless self.destination.empty?
      return true
    else
      return false
    end
  end
end
