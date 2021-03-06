module Backstage
  class BlankPagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_blank_page

    def edit
    end

    def update
      if @blank_page.update(blank_page_params)
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

    def set_blank_page
      @blank_page = @page.pageable
    end

    def blank_page_params
      params.require(:blank_page).permit(:content)
    end
  end
end
