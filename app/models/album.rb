class Album < ApplicationRecord
  belongs_to :company
  has_many :photos, dependent: :destroy

  # serialize :photos, Array
end
