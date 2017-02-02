class Album < ApplicationRecord
  belongs_to :company
  has_many :photos

  # serialize :photos, Array
end
