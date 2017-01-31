class ReviewsController < ApplicationController
  before_filter :set_company, only: [:index, :create, :destroy]
  before_action :authenticate_user!, only: [:index]
  before_filter :set_noindex, only: [:index]

  layout 'personal'

  def index
    @reviews = @company.reviews.page(params[:page])

    render layout: 'backstage'
  end

  def new
    @company = Company.find_by_slug(params[:slug])
    @review = @company.reviews.new
  end

  def create
    @review = @company.reviews.new(review_params)

    if @review.save
      flash[:success] = "Ficamos muito agradecidos pela sua avaliação!"
      redirect_to "/#{@company.slug}"
    else
      flash.now[:alert] = "Por favor verifique os campos."
      render :new
    end
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
    params.require(:review).permit(:stars, :comment)
  end
end
