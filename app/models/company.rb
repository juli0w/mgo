class Company < ApplicationRecord
  paginates_per 10
  include SearchCop

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  scope :premium, -> { where(premium: true) }

  search_scope :search do
    attributes :name, :description
    attributes :categories => ["category.name"]
    attributes :cities => ["city.name"]
    attributes :tags => ["tags.name"]
  end

  mount_uploader :logotipo, LogotipoUploader
  after_update :crop_logo
  def crop_logo
    logotipo.recreate_versions! if crop_x.present?
  end


  FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/
  validates :slug, presence: true,
                   uniqueness: {case_sensitive: false},
                   format: {with: Regexp.new('\A' + FORMAT.source + '\z')}

  validates :name, presence: true
  validates :category_id, presence: true

  belongs_to :user, optional: true
  belongs_to :category
  belongs_to :city, optional: true
  belongs_to :uf, optional: true
  has_one :profile
  has_many :reviews
  has_many :taggings
  has_many :albums
  has_many :tags, through: :taggings
  has_many :subscribes
  has_many :contacts

  delegate :color, to: :profile
  delegate :color_sample, to: :profile

  def activate!
    update(premium: true)
  end

  def unactivate!
    update(premium: false)
  end

  ### TAGS

  def self.by_tag tag
    companies = Tag.find_by_name(tag).try(:companies)
    if companies.present?
      return companies.first(5)
    else
      return Company.offset(rand(Company.count)).first(5)
    end
  end

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
    begin
      self.tags = names.split(',').map do |n|
        Tag.where(name: n.strip).first_or_create
      end
    rescue
    end
  end

  ###

  def city_uf
    "#{city.try(:name)}/#{uf.try(:name)}" if city and uf
  end

  def formatted_address
    if self.city and self.uf
      return "#{self.address} - #{self.city.name.humanize}/#{self.uf.name.upcase}"
    else
      return self.address
    end
  end

  def shows field
    value = send(field)
    value.present? ? value : "Não informado"
  end

  def cover
    if profile.cover?
      profile.cover
    else
      '/images/user-profile-bg.jpg'
    end
  end

  def note
    return 0 if reviews.count <= 0
    (reviews.sum(&:stars) / reviews.count).to_i
  end

  def address_code
    formatted_address.gsub(' ', '+') if self.address.present?
  end
end
