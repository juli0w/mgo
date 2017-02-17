require "json"
require "http"
require "optparse"

class Yelp
  CLIENT_ID = 'VOWaWUu-4c_yey1HJ6tV4g'
  CLIENT_SECRET = 'Ckma0skfg4ej0rlQN4pn0SexyDOvCOarDq7NSQImLZRsWeeJdNjrCb1t36iXAm7Y'

  API_HOST = "https://api.yelp.com"
  SEARCH_PATH = "/v3/businesses/search"
  BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  TOKEN_PATH = "/oauth2/token"
  GRANT_TYPE = "client_credentials"


  DEFAULT_BUSINESS_ID = "meuguia-joinville"
  DEFAULT_TERM = "balada"
  DEFAULT_LOCATION = "Joinville SC"
  SEARCH_LIMIT = 50

  def self.reset!
    Review.delete_all
    Profile.delete_all
    Map.delete_all
    Company.delete_all
    Category.delete_all
  end

  def self.import!
    yelp = Yelp.new

    Category.childs.each do |category|
      extract_companies(yelp.search(category.code, DEFAULT_LOCATION), category.id)
    end

    Map.refresh
  end

  def self.extract_companies json, category_id
    json["businesses"].each do |business|
      # category = Category.where(code: business["categories"][0]["alias"]).first
      # next unless category
      # category_id = category.id
      next if Company.where(code: business["id"]).any?

      lat = business["coordinates"]["latitude"]
      lng = business["coordinates"]["longitude"]
      c = Company.where({ name: business["name"],
                          code: business["id"],
                          slug: business["id"].parameterize,
                          category_id: category_id }).first_or_create

      c.update({ lat: lat,
                 lng: lng })

      city_id = City.where(name: business["location"]["city"]).first_or_create.id
      uf_id = Uf.where(name: business["location"]["state"]).first_or_create.id

      profile = c.profile || c.create_profile
      profile.update({ phone: business["display_phone"],
                       city_id: city_id,
                       uf_id: uf_id,
                       address: business["location"]["address1"] })
    end
  end

  def bearer_token
    # Put the url together
    url = "#{API_HOST}#{TOKEN_PATH}"

    raise "Please set your CLIENT_ID" if CLIENT_ID.nil?
    raise "Please set your CLIENT_SECRET" if CLIENT_SECRET.nil?

    # Build our params hash
    params = {
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      grant_type: GRANT_TYPE
    }

    response = HTTP.post(url, params: params)
    parsed = response.parse

    "#{parsed['token_type']} #{parsed['access_token']}"
  end

  def search(term, location)
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      # term: term,
      categories: term,
      location: location,
      # limit: 50,
      locale: 'pt_BR'
    }

    response = HTTP.auth(bearer_token).get(url, params: params)
    response.parse
  end

  def business(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

    response = HTTP.auth(bearer_token).get(url)
    response.parse
  end
end
