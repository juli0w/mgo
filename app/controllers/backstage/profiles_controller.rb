module Backstage
  class ProfilesController < Backstage::ApplicationController
    def edit
      @company = current_user.companies.find(params[:company_id])
      @profile = @company.profile || @company.create_profile
    end

    def update
      @company = current_user.companies.find(params[:company_id])
      @profile = @company.profile || @company.create_profile

      if @profile.update(profile_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to [:edit, :backstage, @company, :profile]
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

  private

    def profile_params
      params.require(:profile).permit(:institutional,
        :primary_color, :detail_color, :text_color, :link_color, :logo_color, :description_color, :cover)
    end
  end
end
