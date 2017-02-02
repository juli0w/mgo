class PhotosController < ApplicationController
  layout 'backstage'
  before_filter :set_company
  before_filter :set_album
  before_action :authenticate_user!
  before_filter :set_noindex, only: [:index]

  def index
    @photos = @album.photos
    @photo = @album.photos.new
  end

  def create
    @photo = @album.photos.create(photo_params)

    flash[:error] = "Ocorreu um erro" unless @photo.save
    redirect_to company_album_photos_path(@company, @album)
  end

  def destroy
    @photo = @album.photos.find(params[:id])
    flash[:error] = "Ocorreu um erro." unless @photo.destroy
    redirect_to company_album_photos_path(@company, @album)
  end

private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_album
    @album = @company.albums.find(params[:album_id])
  end

  def photo_params
    params.require(:photo).permit(:photo, :description)
  end
end
