class Category < ApplicationRecord
  paginates_per 10

  has_many :companies
end
