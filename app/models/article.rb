class Article < ApplicationRecord
  belongs_to :company
  
  mount_uploader :cover, CoverUploader
end
