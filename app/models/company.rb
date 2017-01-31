class Company < ApplicationRecord
  paginates_per 10

  belongs_to :category
  has_one :profile
  has_many :reviews
  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by!(name: name).companies
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  serialize :photos, Array

  mount_uploader :logotipo, LogotipoUploader
  mount_uploaders :photos, PhotoUploader

  validates_uniqueness_of :slug

  def note
    return 0 if reviews.count <= 0
    (reviews.sum(&:stars) / reviews.count).to_i
  end

  def address_code
    return nil if profile.nil?

    "#{profile.address} #{profile.city}/#{profile.uf}".gsub(' ', '+')
  end

  def self.search params
    if params[:key].blank?
      self.all
    else
      self.left_outer_joins(:profile).
              where('profiles.address LIKE :key
                     or profiles.city LIKE :key
                     or profiles.uf LIKE :key
                     or name LIKE :key
                     or description LIKE :key',
                    key: "%#{params[:key]}%")
    end
  end
end
