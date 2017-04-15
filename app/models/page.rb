class Page < ApplicationRecord
  belongs_to :profile
  belongs_to :pageable, polymorphic: true, dependent: :destroy

  delegate :company, to: :profile

  FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/
  validates :slug, presence: true,
                   format: {with: Regexp.new('\A' + FORMAT.source + '\z')}

  PAGE_TYPES = { 'Módulos' => [
                  [ "Álbum", AlbumPage ],
                  [ "Formulário de contato", ContactPage ],
                  [ "Blog", BlogPage ],
                  [ "Página em branco", BlankPage ]],
                 'Promocional' => [
                  [ "Landing", LandingPage ],
                  [ "Formulário", SubscribePage ],
                  [ "Upsell", UpsellPage ]] }

  def setup
    self.pageable = self.pageable_type.constantize.create
    save
  end

  def link root_url=nil
    "#{self.company.link(root_url)}/#{self.slug}"
  end

  def partial_link
    partial = self.pageable.class.to_s.underscore
    "layouts/themes/#{self.profile.layout}/#{partial.pluralize}/#{partial}"
  end
end
