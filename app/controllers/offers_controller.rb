class OffersController < ApplicationController
  def index
    if params[:keyword].present?
      @offers = Offer.search(params[:keyword]).page(params[:page])
    else
      @offers = Offer.all.page(params[:page])
    end
  end
end
