class Album < ApplicationRecord
  belongs_to :company

  serialize :photos, Array
  mount_uploaders :photos, PhotoUploader
end
