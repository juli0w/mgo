module Backstage
  class AlbumsController < Backstage::ApplicationController
    before_filter :set_company
    before_filter :set_album, only: [:edit, :update, :destroy]

    def index
      @albums = @company.albums
    end

    def new
      @album = @company.albums.new
    end

    def create
      @album = @company.albums.new(album_params)

      if @album.save
        flash[:success] = "Álbum criado!"
        redirect_to edit_backstage_company_album_path(@company, @album)
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :new
      end
    end

    def edit
    end

    def update
      if @album.update(album_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to edit_backstage_company_album_path(@company)
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

    def destroy
      @album.delete

      flash[:success] = "Salvo com sucesso!"
      redirect_to backstage_company_albums_path(@company)
    end

  private

    def set_company
      @company = current_user.companies.find(params[:company_id])
    end

    def set_album
      @album = @company.albums.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :description)
    end
  end
end
