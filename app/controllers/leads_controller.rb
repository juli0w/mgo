class LeadsController < ApplicationController
  before_action :set_company, only: [:create]

  def create
    @lead = @company.leads.new(lead_params)

    if @lead.save
      flash.now[:success] = "Você está inscrito na nossa lista! Adicione nosso email na sua lista de contatos"
    else
      flash.now[:alert] = "Não conseguimos salvar seu email"
    end

    redirect_to (session["previous_url"] || @company.link(root_path))
  end

private

  def set_company
    @company = Company.find_by_slug(params[:slug])
  end

  def lead_params
    params.require(:lead).permit(:email)
  end
end
