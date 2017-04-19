class Copywrite < ApplicationRecord
  has_many :copywritings
  has_many :copywrite_blocks, through: :copywritings
end
