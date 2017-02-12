class OffersController < ApplicationController
  def index
    set_meta_tags title: "Ofertas e promoções",
                  description: 'Ofertas exclusivas para usuários do meu guia'

    if params[:keyword].present?
      @offers = Offer.search(params[:keyword]).page(params[:page])
    else
      @offers = Offer.all.page(params[:page])
    end
  end
end
