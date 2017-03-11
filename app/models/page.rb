class Page < ApplicationRecord
  belongs_to :profile
  belongs_to :pageable, polymorphic: true, dependent: :destroy

  FORMAT = /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/
  validates :slug, presence: true,
                   format: {with: Regexp.new('\A' + FORMAT.source + '\z')}

  PAGE_TYPES = [[ "Página em branco", BlankPage ],
                [ "Formulário de contato", ContactPage ],
                [ "Álbum", AlbumPage ]]

  def setup
    self.pageable = self.pageable_type.constantize.create
    save
  end
end
