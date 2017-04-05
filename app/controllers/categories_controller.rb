class CategoriesController < ApplicationController
  before_filter :set_category, only: [:show]

  def show
    set_meta_tags title: @category.name,
                  description: "Confira todas as IDÉIAS impulsionadas pelo Weekz relacionadas a #{@category.name}"

    # if @category.root?
    #   @children = @category.children.page params[:page]
    #   render 'categories'
    # else
    @companies = @category.companies.search(params[:key]).order('premium desc, logotipo desc').page(params[:page])
    # end
  end

private

  def set_category
    @category = Category.find(params[:id])
  end
end
