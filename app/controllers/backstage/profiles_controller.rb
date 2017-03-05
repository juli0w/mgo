module Backstage
  class ProfilesController < Backstage::ApplicationController
    def edit
      @company = current_user.companies.find(params[:company_id])
      @profile = @company.profile || @company.create_profile
      @template = @profile.template || @profile.create_template
    end

    def update
      @company = current_user.companies.find(params[:company_id])
      @profile = @company.profile

      if @profile.update(profile_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to [:edit, :backstage, @company, :profile]
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

    def preview
      @company = current_user.companies.find(params[:company_id])
      @contact = Contact.new
      @albums = @company.albums
      
      render layout: 'preview'
    end

  private

    def profile_params
      params.require(:profile).permit(:institutional, :cover,
        template_attributes: [:primary_color_id, :detail_color_id, :text_color_id, :link_color_id,
        :logo_color_id, :description_color_id])
    end
  end
end
