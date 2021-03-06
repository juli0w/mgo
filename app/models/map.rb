require 'open-uri'

class Map < ApplicationRecord
  belongs_to :company
  validates :company_id, presence: true
  validates :lat, presence: true
  validates :lng, presence: true

  def self.refresh
    Map.delete_all

    companies = Company.all.each do |company|
      # link = "http://maps.googleapis.com/maps/api/geocode/json?address=#{company.profile.address}&sensor=false"
      # url = URI.encode(link)
      # response = JSON.load(open(url))
      begin
        Map.create(company_id: company.id,
                   lat: company.lat,
                   lng: company.lng)
                  #  lat: response["results"][0]["geometry"]["location"]["lat"],
                  #  lng: response["results"][0]["geometry"]["location"]["lng"])
      rescue
      end
    end
  end
end
