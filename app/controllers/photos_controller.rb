class PhotosController < ApplicationController
  layout 'backstage'
  before_filter :set_company
  before_action :authenticate_user!
  before_filter :set_noindex, only: [:index]

  def index
    @photos = @company.photos
  end

  def create
    add_more_images(photo_params[:photos])
    flash[:error] = "Ocorreu um erro" unless @company.save
    redirect_to company_photos_path(@company)
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Ocorreu um erro." unless @company.save
    redirect_to company_photos_path(@company)
  end

private

  def add_more_images(new_images)
    images = @company.photos
    images += new_images
    @company.photos = images
  end

  def remove_image_at_index(index)
    remain_images = @company.photos
    deleted_image = remain_images.delete_at(index)
    @company.photos = remain_images
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def photo_params
    params.require(:company).permit({ photos: [] })
  end
end
