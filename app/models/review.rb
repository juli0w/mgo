class Review < ApplicationRecord
  paginates_per 10

  belongs_to :company

  validates :stars, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validate :email_in_use

private

  def email_in_use
    if Review.where(company_id: company_id, email: email).first
      errors.add(:email, "Você já avaliou essa empresa")
    end
  end
end
