class Company < ApplicationRecord
  paginates_per 10
  acts_as_taggable_on :tags
  include SearchCop

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  scope :premium, -> { where(premium: true) }

  search_scope :search do
    attributes :name, :description
    attributes :categories => ["category.name"]
    attributes :cities => ["city.name"]
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

  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :city, optional: true
  belongs_to :uf, optional: true
  has_one :profile, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :subscribes, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :articles, dependent: :destroy

  delegate :color, to: :profile
  delegate :color_sample, to: :profile
  delegate :layout_path, to: :profile
  delegate :layout, to: :profile

  def activate!
    update(premium: true)
  end

  def unactivate!
    update(premium: false)
  end

  def link root=nil
    path = self.domain.present? ? "#{self.domain}" : "#{root}#{self.slug}"
    unless path[/\Ahttp:\/\//] || path[/\Ahttps:\/\//]
      path = "http://#{path}"
    end

    return path
  end

  def city_uf
    "#{city.try(:name)}/#{uf.try(:name)}" if city and uf
  end

  def formatted_address
    if self.city and self.uf
      return "#{self.shows(:address)} - #{self.city.name.humanize}/#{self.uf.name.upcase}"
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
