module Backstage
  class SubscribePagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_subscribe_page

    def edit
    end

    def update
      if @subscribe_page.update(subscribe_page_params)
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

    def set_subscribe_page
      @subscribe_page = @page.pageable
    end

    def subscribe_page_params
      params.require(:subscribe_page).permit(:link, :link_call)
    end
  end
end
