module Backstage
  class NewslettersController < Backstage::ApplicationController
    def edit
      @company = current_user.companies.find(params[:company_id])
      @newsletter = @company.newsletter || @company.create_newsletter
      @template = @newsletter.template || @newsletter.create_template
      @leads = @company.leads.page(params[:page])
    end

    def update
      @company = current_user.companies.find(params[:company_id])
      @newsletter = @company.newsletter

      if @newsletter.update(newsletter_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to [:edit, :backstage, @company, :newsletter]
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

    def destroy
      @company = current_user.companies.find(params[:company_id])
      @lead = @company.leads.find(params[:id])
      @lead.destroy

      flash[:success] = "Removido com sucesso!"
      redirect_to [:edit, :backstage, @company, :newsletter]
    end

  private

    def newsletter_params
      params.require(:newsletter).permit(:top, :bottom, :message, :action,
        template_attributes: [:primary_color_id, :detail_color_id, :text_color_id, :link_color_id])
    end
  end
end
