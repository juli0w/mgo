module Backstage
  class PagesController < Backstage::ApplicationController
    before_filter :set_profile
    before_filter :set_page, only: [:edit, :update, :destroy]

    def index
      @pages = @profile.pages.order(:index)
    end

    def new
      @page = @profile.pages.new
    end

    def create
      @page = @profile.pages.new(page_params)

      if @page.setup
        flash[:success] = "Página criada!"
        redirect_to polymorphic_path([:edit, :backstage, @company, @page, @page.pageable])
      else
        flash.now[:alert] = "Por favor verifique os campos"
        render :new
      end
    end

    def edit
    end

    def update
      if @page.update(page_params)
        flash[:success] = "Página atualizada"
        redirect_to [:backstage, @company, :pages]
      else
        flash.now[:alert] = "Por favor verifique os campos"
        render :new
      end
    end

    def destroy
      @page.pageable.try(:delete)
      @page.delete

      flash[:success] = "Página deletada com sucesso!"
      redirect_to backstage_company_pages_path(@company)
    end

  private

    def set_profile
      @company = current_user.companies.find(params[:company_id])
      @profile = @company.profile || @company.create_profile
    end

    def set_page
      @page = @profile.pages.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :index, :description, :slug, :pageable_type)
    end
  end
end
