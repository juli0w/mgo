class Company < ApplicationRecord
  paginates_per 10
  include SearchCop

  search_scope :search do
    attributes :name, :description
    attributes :categories => ["category.name"]
    attributes :cities => ["city.name"]
    attributes :tags => ["tags.name"]
    # attributes :profile => "profile.city.name"

    # options :all, :type => :fulltext, :default => true
  end


  SLUG_FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/

  validates :name, presence: true
  validates :slug, presence: true,
                   uniqueness: {case_sensitive: false},
                   format: {with: Regexp.new('\A' + SLUG_FORMAT.source + '\z')}

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

  DEFAULT_COLOR = { primary_color: "grey darken-1",
                    detail_color: "yellow-text text-accent-2",
                    link_color: "yellow-text",
                    text_color: "white-text",
                    logo_color: "white-text",
                    description_color: "white-text" }

  def color kind
    c = profile.send(kind)

    if c.present? and self.premium?
      c
    else
      return DEFAULT_COLOR[kind]
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
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  mount_uploader :logotipo, LogotipoUploader

  def city_uf
    "#{profile.city.name}/#{profile.uf.name}" if profile.city and profile.uf
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
