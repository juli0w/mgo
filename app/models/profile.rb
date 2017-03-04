class Profile < ApplicationRecord
  belongs_to :company

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
end
