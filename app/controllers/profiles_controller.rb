class ProfilesController < ApplicationController
  layout 'backstage'
  before_action :authenticate_user!, only: [:edit, :update]
  before_filter :set_noindex, only: [:edit]

  def edit
    @company = Company.find(params[:company_id])
    @profile = @company.profile || @company.create_profile
  end

  def update
    @company = Company.find(params[:company_id])
    @profile = @company.profile || @company.create_profile

    if @profile.update(profile_params)
      flash[:success] = "Salvo com sucesso!"
      redirect_to [:edit, @company, :profile]
    else
      flash.now[:alert] = "Por favor verifique os campos."
      render :new
    end
  end

private

  def profile_params
    params.require(:profile).permit(:institutional,
      :phone, :mail, :city, :uf, :address, :primary_color,
      :detail_color, :text_color, :link_color, :logo_color, :description_color, :cover)
  end
end
