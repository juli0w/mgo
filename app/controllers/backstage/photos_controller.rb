module Backstage
  class PhotosController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_album_page

    def index
      @photos = @album_page.photos
      @photo = @album_page.photos.new
    end

    def create
      @photo = @album_page.photos.create(photo_params)

      flash[:error] = "Ocorreu um erro" unless @photo.save
      redirect_to [:backstage, @company, @page, @album_page, :photos]
    end

    def destroy
      @photo = @album_page.photos.find(params[:id])

      flash[:error] = "Ocorreu um erro." unless @photo.destroy
      redirect_to [:backstage, @company, @page, @album_page, :photos]
    end

  private

    def set_page
      @company = current_user.companies.find(params[:company_id])
      @page = @company.profile.pages.find(params[:page_id])
    end

    def set_album_page
      @album_page = @page.pageable
    end

    def photo_params
      params.require(:photo).permit(:photo, :description)
    end
  end
end
