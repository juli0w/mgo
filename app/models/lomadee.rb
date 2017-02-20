require 'open-uri'

class Lomadee
  TOKEN = '56513174687750345237733d'
  # URL = 'http://sandbox.buscape.com'
  URL = 'http://bws.buscape.com.br'
  SOURCE_ID = '35748727'
  API = {
    offers: "v2/topOffers",
    offers_list: "findOfferList",
    products: "v2/topProducts",
    categories: "v2/topCategories",
    product_list: "findProductList"
  }

  RESULTS = 20

  def self.get_path type
    URL + "/service/#{API[type]}/lomadee/#{TOKEN}/BR/?format=json&sourceId=#{SOURCE_ID}&results=#{RESULTS}"
  end

  ### offer
  # - offerName
  # - categoryName
  # - priceValue
  # - priceFromValue
  # - thumbnail > url
  # - links > link > 0 > url
  def self.read type, page=1, keywords=''
    url = URI.encode("#{get_path(type)}&page=#{page}&sort=rate&keyword=#{keywords}")
    response = JSON.load(open(url))

    # puts "---"
    # puts "--- Acessando #{url}"
    # puts "--- "

    return response
  end

  def self.page page=1
    self.read(:offers, page)
  end

  def self.search keywords, page=1
    self.read(:offers_list, page, keywords)
  end

  # def self.offers
  #   total_pages = self.read(:offers)["totalPages"]
  #   page = 1
  #   pages = []
  #   until (page >= total_pages) do
  #     page += 1
  #     pages << self.read(:offers, page)["offer"]
  #   end
  #
  #   return pages
  # end
end
