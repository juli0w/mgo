class Article < ApplicationRecord
  acts_as_commentable
  acts_as_taggable_on :tags
  belongs_to :company

  mount_uploader :cover, CoverUploader

  include SearchCop
  search_scope :search do
    attributes :title, :description, :slug, :content
  end
end
