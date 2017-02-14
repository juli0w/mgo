module Backstage
  class ReviewsController < Backstage::ApplicationController
    before_filter :set_company, only: [:index, :destroy]

    def index
      @reviews = @company.reviews.page(params[:page])

      render layout: 'backstage'
    end

    def destroy
      @review = @company.reviews.find(params[:id])
      @review.delete

      flash[:success] = "Removido com sucesso!"
      redirect_to :back
    end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def review_params
      params.require(:review).permit(:stars, :comment, :name, :email)
    end
  end
end
