class ReviewsController < ApplicationController
  before_action :set_company, only: [:create]
  layout 'company'

  def new
    @company = Company.find_by_slug(params[:slug])
    @review = @company.reviews.new

    @hide_menu = true
  end

  def create
    @review = @company.reviews.new(review_params)

    if @review.save
      flash[:success] = "Ficamos muito agradecidos pela sua avaliação!"
      redirect_to "/#{@company.slug}"
    else
      flash.now[:alert] = "Por favor verifique os campos."
      @hide_menu = true
      render :new
    end
  end

private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def review_params
    params.require(:review).permit(:stars, :comment, :name, :email)
  end
end
