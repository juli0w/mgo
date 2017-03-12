module Backstage
  class CompaniesController < Backstage::ApplicationController
    before_action :set_company, only: [:show, :edit, :update, :destroy]
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
    end

    def new
      @company = current_user.companies.new
    end

    def create
      @company = current_user.companies.new(company_params)

      if @company.save
        @company.create_profile

        if params[:company][:logotipo].present?
          render :crop
        else
          flash[:success] = "Empresa criada!"
          redirect_to edit_backstage_company_profile_path(@company)
        end
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :new
      end
    end

    def edit
    end

    def update
      if @company.update(company_params)
        if params[:company][:logotipo].present?
          render :crop
        else
          flash[:success] = "Salvo com sucesso!"
          redirect_to edit_backstage_company_profile_path(@company)
        end
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

    def destroy
      @company.destroy
      redirect_to backstage_companies_path
    end

  private

    def set_company
      @company = current_user.companies.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name,
        :description, :crop_x, :crop_y, :crop_w, :crop_h, :category_id,
        :logotipo, :slug, :tag_list, :facebook, :twitter, :instagram,
        :phone, :mail, :city_id, :uf_id, :address)
    end
  end
end
