class PhotosController < ApplicationController
  layout 'backstage'
  before_filter :set_company
  before_filter :set_album
  before_action :authenticate_user!
  before_filter :set_noindex, only: [:index]

  def index
    @photos = @album.photos
  end

  def create
    add_more_images(photo_params[:photos])
    flash[:error] = "Ocorreu um erro" unless @album.save
    redirect_to company_album_photos_path(@company, @album)
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Ocorreu um erro." unless @album.save
    redirect_to company_album_photos_path(@company, @album)
  end

private

  def add_more_images(new_images)
    images = @album.photos
    images += new_images
    @album.photos = images
  end

  def remove_image_at_index(index)
    remain_images = @album.photos
    deleted_image = remain_images.delete_at(index)
    @album.photos = remain_images
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_album
    @album = @company.albums.find(params[:album_id])
  end

  def photo_params
    params.require(:album).permit({ photos: [] })
  end
end
