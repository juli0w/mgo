class CategoriesController < ApplicationController
  layout 'backstage'
  before_filter :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :set_noindex, only: [:index, :new, :edit]

  def index
    @categories = Category.page params[:page]
  end

  def show
    set_meta_tags title: @category.name,
                  description: 'Lista de empresas por categoria'

    if @category.root?
      @children = @category.children.page params[:page]
      render 'categories', layout: 'application'
    else
      @companies = @category.companies.page(params[:page])
      render 'show', layout: 'application'
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Categoria criada!"
      redirect_to categories_path
    else
      flash.now[:alert] = "Por favor verifique os campos."
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Salvo com sucesso!"
      redirect_to categories_path
    else
      flash.now[:alert] = "Por favor verifique os campos."
      render :edit
    end
  end

  def destroy
    @category.delete

    flash[:success] = "Categoria removida"
    redirect_to categories_path
  end

private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :ancestor_id)
  end
end
