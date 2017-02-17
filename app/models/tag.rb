class Tag < ApplicationRecord
  has_many :taggings
  has_many :companies, through: :taggings

  validates :name, presence: true,
                   format: {with: Regexp.new('\A' + Company::FORMAT.source + '\z')}
end
