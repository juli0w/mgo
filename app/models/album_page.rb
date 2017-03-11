class AlbumPage < ApplicationRecord
  has_many :photos, dependent: :destroy
end
