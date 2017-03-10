class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update]

  def tag
    @tag = Tag.where(name: params[:tag]).first
    @companies = Company.tagged_with(params[:tag]).order('premium desc, logotipo desc').page(params[:page])
  end

  def show
    @company = Company.find_by_slug(params[:slug])
    @template = @company.profile.template
    @contact = Contact.new
    @albums = @company.albums

    @page_keywords += ", " + @company.tag_list
    @row_counter = 1

    @preview = false
    if params[:preview] == @company.id
      @preview = true
    end

    set_meta_tags title: @company.description,
                  description: "Página sobre a empresa #{@company.name}. #{@company.description}. #{@company.tag_list}"

    render layout: 'full'
  end

private

  def set_company
    @company = Company.find(params[:id])
  end
end
