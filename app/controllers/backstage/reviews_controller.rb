module Backstage
  class ReviewsController < Backstage::ApplicationController
    before_action :set_company, only: [:index, :destroy]

    def index
      @reviews = @company.reviews.page(params[:page])
    end

    def destroy
      @review = @company.reviews.find(params[:id])
      @review.delete

      flash[:success] = "Removido com sucesso!"
      redirect_to :back
    end

  private

    def set_company
      @company = current_user.companies.find(params[:company_id])
    end
  end
end
