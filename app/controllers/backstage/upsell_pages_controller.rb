module Backstage
  class UpsellPagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_upsell_page

    def edit
    end

    def update
      if @upsell_page.update(upsell_page_params)
        flash[:success] = "Página modificada com sucesso!"
        redirect_to polymorphic_path([:edit, :backstage, @company, @page, @upsell_page])
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

    def set_upsell_page
      @upsell_page = @page.pageable
    end

    def upsell_page_params
      params.require(:upsell_page).permit(:image, :content, :link, :link_call)
    end
  end
end
