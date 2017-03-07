class GoogleLocals
  GOOGLE_API = "AIzaSyDfctwo0ySKVTElaXSd2IphEEoMKWW32_s"
  CITY = "Joinville"
  UF = "SC"

  LAT = -26.3044084
  LNG = -48.8463832

  TYPES = [:establishment, :point_of_interest]

  def self.reset!
    Review.delete_all
    Profile.delete_all
    Map.delete_all
    Company.delete_all
    Category.delete_all
    Photo.delete_all
    Album.delete_all
    Subscribe.delete_all
    Tagging.delete_all
    Tag.delete_all
    Template.delete_all
  end

  def self.import!
    client = GooglePlaces::Client.new(GOOGLE_API)

    Category.childs.each do |category|
      extract_places(client.spots_by_query("#{category.name} #{CITY} #{UF}", types: TYPES), client, category.id)
    end

    Map.refresh
  end

  def self.extract_places places, client, category_id
    places.each do |place|
      place_id = place.place_id
      lat = place.lat
      lng = place.lng

      spot = client.spot(place_id)

      next if spot.city != CITY
      city_id = City.where(name: spot.city).first_or_create.id
      uf_id = Uf.where(name: UF).first_or_create.id

      address = "#{spot.street}, #{spot.street_number}"

      c = Company.where({ name: spot.name,
                          code: place_id,
                          slug: spot.name.parameterize,
                          category_id: category_id,
                          phone: spot.formatted_phone_number,
                          city_id: city_id,
                          uf_id: uf_id,
                          address: address}).first_or_create.create_profile.create_template

      if spot.photos.count > 0
        c.update(remote_logotipo_url: spot.photos[0].fetch_url(800))
      end
    end
  end
end
