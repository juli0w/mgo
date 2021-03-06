class ReviewsController < ApplicationController
  before_action :set_company, only: [:create]

  def new
    @company = Company.find_by_slug(params[:slug])
    if @company
      @pages = @company.profile.pages
      @review = @company.reviews.new

      render layout: @company.profile.layout_path
    else
      not_found
    end
  end

  def create
    @review = @company.reviews.new(review_params)

    if @review.save
      flash[:success] = "Ficamos muito agradecidos pela sua avaliação!"
      redirect_to "/#{@company.slug}"
    else
      flash.now[:alert] = "Por favor verifique os campos."
      @hide_menu = true
      render :new, layout: @company.profile.layout_path
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
