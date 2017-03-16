class Article < ApplicationRecord
  acts_as_commentable
  belongs_to :company

  mount_uploader :cover, CoverUploader
end
