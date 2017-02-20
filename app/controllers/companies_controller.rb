class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update]

  def tag
    @tag = Tag.where(name: params[:tag]).first
    @companies = Company.tagged_with(params[:tag]).page(params[:page])
  end

  def show
    @company = Company.find_by_slug(params[:slug])
    @contact = Contact.new
    @albums = @company.albums

    @page_keywords += ", " + @company.tag_list

    set_meta_tags title: @company.description,
                  description: "Página sobre a empresa #{@company.name}"

    render layout: 'personal'
  end

private

  def set_company
    @company = Company.find(params[:id])
  end
end
