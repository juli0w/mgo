class CompaniesController < ApplicationController
  layout 'backstage'
  before_filter :set_company, only: [:edit, :update]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update]
  before_filter :set_noindex, only: [:index, :new, :edit]

  def index
    @companies = Company.page params[:page]
  end

  def show
    @company = Company.find_by_slug(params[:slug])
    @contact = Contact.new
    @photos = @company.photos
    @reviews = @company.reviews
    @page_keywords += ", " + @company.tag_list

    set_meta_tags title: @company.description,
                  description: "Página sobre a empresa #{@company.name}"

    render layout: 'personal'
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:success] = "Empresa criada!"
      redirect_to edit_company_profile_path(company_id: @company.id)
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
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description, :category_id, :logotipo, :slug, :tag_list, :facebook, :twitter, :instagram)
  end
end
