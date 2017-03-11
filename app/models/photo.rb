class Photo < ApplicationRecord
  belongs_to :album_page

  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
end
