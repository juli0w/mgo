module Backstage
  class CompaniesController < Backstage::ApplicationController
    before_action :set_company, only: [:edit, :update]
    before_action :authenticate_admin!, only: [:active, :unactive]

    def index
      if params[:keyword].present?
        @companies = current_user.companies.where("name LIKE ?", "%#{params[:keyword]}%").page(params[:page])
      else
        @companies = current_user.companies.page params[:page]
      end
    end

    def active
      @company = Company.find(params[:id])
      @company.activate!

      flash[:success] = "Premium ativado"
      redirect_to :back
    end

    def unactive
      @company = Company.find(params[:id])
      @company.unactivate!

      flash[:success] = "Premium desativado"
      redirect_to :back
    end

    def show
      @company = current_user.companies.find(params[:id])
    end

    def new
      @company = current_user.companies.new
    end

    def create
      @company = current_user.companies.new(company_params)

      if @company.save
        flash[:success] = "Empresa criada!"
        redirect_to edit_backstage_company_profile_path(company_id: @company.id)
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :new
      end
    end

    def edit
    end

    def update
      if @company.update(company_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to :back
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

  private

    def set_company
      @company = current_user.companies.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :description, :category_id, :logotipo, :slug, :tag_list, :facebook, :twitter, :instagram)
    end
  end
end
