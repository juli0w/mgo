class Review < ApplicationRecord
  paginates_per 10

  belongs_to :company

  validates :stars, presence: true
end
