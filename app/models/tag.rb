class Tag < ApplicationRecord
  has_many :taggings
  has_many :companies, through: :taggings

  FORMAT = /[\w \.\-@]+/

  validates :name, presence: true,
                   format: {with: Regexp.new('\A' + FORMAT.source + '\z')}
end
