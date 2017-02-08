class Offer < ApplicationRecord
  paginates_per 27

  def self.search key
    if key.blank?
      self.all
    else
      self.where('name LIKE :key
                     or category_name LIKE :key',
                    key: "%#{key}%")
    end
  end

  def self.import!
    Offer.delete_all

    Lomadee.offers.each do |page|
      page.each do |offer|
        offer = new(name: offer["offerName"].gsub(/[\u0080-\u00ff]/, ''),
                    category_name: offer["categoryName"].gsub(/[\u0080-\u00ff]/, ''),
                    price_from: offer["priceFromValue"],
                    price: offer["priceValue"],
                    thumbnail: offer["thumbnail"]["url"],
                    link: offer["links"]["link"][0]["url"],
                    seller_thumbnail: offer["seller"]["thumbnail"]["url"])

        offer.save
      end
    end
  end
end
