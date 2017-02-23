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

    # options :all, :type => :fulltext, :default => true
  end

  after_update :crop_logo
  def crop_logo
    logotipo.recreate_versions! if crop_x.present?
  end

  FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/

  validates :name, presence: true
  validates :slug, presence: true,
                   uniqueness: {case_sensitive: false},
                   format: {with: Regexp.new('\A' + FORMAT.source + '\z')}

  validates :category_id, presence: true

  belongs_to :user, optional: true
  belongs_to :category
  has_one :profile
  has_one :city, through: :profile
  has_many :albums
  has_many :reviews
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :subscribes
  has_many :contacts

  DEFAULT_COLOR = { primary_color: "blue-grey darken-2",
                    detail_color: "amber-text",
                    link_color: "amber-text",
                    text_color: "white-text",
                    logo_color: "white-text",
                    description_color: "white-text" }

  def self.by_tag tag
    companies = Tag.find_by_name(tag).try(:companies)
    if companies.present?
      return companies.first(5)
    else
      return Company.offset(rand(Company.count)).first(5)
    end
  end

  def color kind, force=false
    c = profile.send(kind)

    if (c.present?) and (self.premium? or force)
      c
    else
      return DEFAULT_COLOR[kind]
    end
  end

  def activate!
    update(premium: true)
  end

  def unactivate!
    update(premium: false)
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
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  mount_uploader :logotipo, LogotipoUploader

  def city_uf
    "#{profile.city.try(:name)}/#{profile.uf.try(:name)}" if profile.city and profile.uf
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
    return nil if profile.nil?
    faddress = profile.formatted_address
    faddress.gsub(' ', '+') if faddress
  end

  # def self.search params
  #   if params[:key].blank?
  #     self.all
  #   else
  #     self.left_outer_joins(:profile).
  #             where('profiles.address LIKE :key
  #                    or name LIKE :key
  #                    or description LIKE :key',
  #                   key: "%#{params[:key]}%")
  #   end
  # end
end
