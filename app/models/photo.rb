class Photo < ApplicationRecord
  belongs_to :album

  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
end
