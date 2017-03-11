module Backstage
  class FontsController < Backstage::ApplicationController
    before_filter :set_font, only: [:edit, :update, :destroy]
    before_action :authenticate_admin!

    def index
      if params[:keyword].present?
        @fonts = Font.where("name LIKE ?", "%#{params[:keyword]}%").page(params[:page])
      else
        @fonts = Font.page params[:page]
      end
    end

    def new
      @font = Font.new
    end

    def create
      @font = Font.new(font_params)

      if @font.save
        flash[:success] = "Fonte adicionada!"
        redirect_to backstage_fonts_path
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :new
      end
    end

    def edit
    end

    def update
      if @font.update(font_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to backstage_fonts_path
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

    def destroy
      @font.delete

      flash[:success] = "Fonte removida"
      redirect_to backstage_fonts_path
    end

  private

    def set_font
      @font = Font.find(params[:id])
    end

    def font_params
      params.require(:font).permit(:name, :url)
    end
  end
end
