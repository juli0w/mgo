class Profile < ApplicationRecord
  belongs_to :company
  belongs_to :city
  belongs_to :uf

  validates :address, presence: true

  COLORS = ['red', 'pink', 'purple', 'blue', 'teal', 'green',
            'light-green', 'lime', 'yellow', 'amber', 'blue-grey']


  mount_uploader :cover, CoverUploader

  def self.colors
    colors = []
    COLORS.each do |color|
    ['lighten-3', 'lighten-2', 'lighten-1',
     'base', 'darken-2', 'darken-3', 'darken-4',
     'accent-1', 'accent-2', 'accent-3', 'accent-4'].each do |depth|
         colors << { color: "#{color} #{depth}",
                     text_color: "#{color}-text text-#{depth}" }
       end
    end
    colors << { color: "grey", text_color: "grey-text" }
    colors << { color: "brown", text_color: "brown-text" }
    colors << { color: "orange", text_color: "orange-text" }
    colors << { color: "white", text_color: "white-text" }
    colors << { color: "black", text_color: "black-text" }

    colors
  end

  def formatted_address
    if self.city and self.uf
      return "#{self.address} - #{self.city.name.humanize}/#{self.uf.name.upcase}"
    else
      return self.address
    end
  end

  # def city= city
  #   city_id = City.where(name: city).first_or_create.id
  # end
end
