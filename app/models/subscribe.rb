class Subscribe < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :plan, presence: true
end
