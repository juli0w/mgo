module Backstage
  class LandingPagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_landing_page

    def edit
    end

    def update
      if @landing_page.update(landing_page_params)
        flash[:success] = "Página modificada com sucesso!"
        redirect_to [:backstage, @company, :pages]
      else
        flash.now[:alert] = "Por favor verifique os campos"
        render :new
      end
    end

  private

    def set_page
      @company = current_user.companies.find(params[:company_id])
      @page = @company.profile.pages.find(params[:page_id])
    end

    def set_landing_page
      @landing_page = @page.pageable
    end

    def landing_page_params
      params.require(:landing_page).permit(:image, :content, :link, :details, :link_call)
    end
  end
end
