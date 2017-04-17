module Backstage
  class CompaniesController < Backstage::ApplicationController
    before_action :set_company, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_admin!, only: [:active, :unactive]

    def index
      @companies = current_user.companies.search(params[:key]).page(params[:page])
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
      # respond_to do |format|
      #   format.html { }
      #   format.pdf do
      #     kit = PDFKit.new(<<-HTML)
      #     <p>Hello Envato!</p>
      #     HTML
      #
      #     send_file kit.to_file("public/hello.pdf")
      #   end
      # end
    end

    def new
      @company = current_user.companies.new
    end

    def create
      @company = current_user.companies.new(company_params)

      if @company.save
        @company.create_profile
        @company.create_newsletter

        if params[:company][:logotipo].present?
          render :crop
        else
          flash[:success] = "Empresa criada!"
          redirect_to edit_backstage_company_profile_path(@company)
        end
      else
        errors = @company.errors.map { |name, msg| "#{name} #{msg}" }.first
        flash.now[:alert] = "Por favor verifique os campos: <br>#{errors}".html_safe
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
        errors = @company.errors.map { |name, msg| "#{name} #{msg}" }.first
        flash.now[:alert] = "Por favor verifique os campos: <br>#{errors}".html_safe
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
      params.require(:company).permit(:name, :domain, :analytics_id,
        :description, :crop_x, :crop_y, :crop_w, :crop_h,
        :logotipo, :slug, :tag_list, :facebook, :twitter, :instagram,
        :phone, :mail, :city_id, :uf_id, :address)
    end
  end
end
