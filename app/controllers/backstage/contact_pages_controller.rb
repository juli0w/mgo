module Backstage
  class ContactPagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_contact_page

    def edit
    end

    def update
      if @contact_page.update(contact_page_params)
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

    def set_contact_page
      @contact_page = @page.pageable
    end

    def contact_page_params
      params.require(:contact_page).permit(:email)
    end
  end
end
