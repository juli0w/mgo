class OffersController < ApplicationController
  def index
    set_meta_tags title: "Ofertas e promoções",
                  description: 'Ofertas exclusivas para usuários do Weekz'

    result = Offer.search(params[:keyword], params[:page])
    @offers = result["offer"] || []

    if @offers.present?
      @pages = Kaminari.paginate_array(@offers, total_count: result["totalresultsavailable"]).page(params[:page]).per(20)
    else
      @offers = Offer.offers.first(9)
    end
  end
end
