class Font < ApplicationRecord
  def self.seed!
    %w(Arvo Merriweather Kurale Ultra).each do |font|
      where(name: font,
            url: "https://fonts.googleapis.com/css?family=#{font}").first_or_create
    end
  end
end
