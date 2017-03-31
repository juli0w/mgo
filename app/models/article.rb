class Article < ApplicationRecord
  acts_as_commentable
  acts_as_taggable_on :tags
  belongs_to :company

  mount_uploader :cover, CoverUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_cover
  def crop_cover
    cover.recreate_versions! if crop_x.present?
  end

  include SearchCop
  search_scope :search do
    attributes :title, :description, :slug, :content
  end

  def link
    blog = company.profile.pages.select {|p| p.pageable_type == "BlogPage" }.first
    return "/#{company.slug}" unless blog

    "/#{company.slug}/#{blog.slug}/#{self.slug}"
  end
end
