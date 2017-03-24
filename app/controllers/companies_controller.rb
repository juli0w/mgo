class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update]

  def tag
    set_meta_tags title: 'Principais locais e eventos da região',
    description: "Resultados da busca por tag #{params[:tag]}"

    @tag = ActsAsTaggableOn::Tag.where(name: params[:tag]).first
    @companies = Company.search(params[:key]).tagged_with(params[:tag]).order('premium desc, logotipo desc').page(params[:page])
  end

  def sitemap
    @company = Company.find_by_slug(params[:slug])
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml { render layout: nil }
    end
  end

  def robots
    @company = Company.find_by_slug(params[:slug])
    render 'robots.txt.erb', layout: false, content_type: 'text/plain'
  end

  def show
    @company = Company.find_by_slug(params[:slug])

    if @company.nil?
      not_found
    else
      @template = @company.profile.template
      @pages = @company.profile.pages.order(:index)

      if params[:paging]
        @page = @pages.find_by_slug(params[:paging])
      else
        @page = @pages.first
      end

      @contact = Contact.new
      @row_counter = 1

      load_articles

      @page_keywords += @company.tag_list.join(",")
      set_meta_tags title: @company.description,
                    description: "#{@company.description}. #{@company.tag_list}"

      render layout: @company.profile.layout_path
    end
  end

  def article
    @company = Company.find_by_slug(params[:slug])
    @template = @company.profile.template
    @pages = @company.profile.pages.order(:index)
    @page = @pages.find_by_slug(params[:paging])
    @article = @company.articles.find_by_slug(params[:article])

    @page_keywords += @company.tag_list.join(",")
    set_meta_tags title: "#{@article.title} - #{@page.title}",
                  description: "#{@article.description}"

    render layout: @company.profile.layout_path
  end

  def search
    @company = Company.find_by_slug(params[:slug])
    @template = @company.profile.template
    @pages = @company.profile.pages.order(:index)
    @page = @pages.find_by_slug(params[:paging])
    @articles = @company.articles.search(params[:key]).page(params[:page])

    @page_keywords += @company.tag_list.join(",")
    set_meta_tags title: "#{@page.title} - #{@page.description}",
                  description: "Termos de busca de artigos: #{params[:key]}"

    render layout: @company.profile.layout_path
  end

private

  def load_articles
    blog = @pages.select{|a| a.pageable_type == "BlogPage" }
    unless blog.blank?
      @articles = @company.articles.search(params[:key]).order("id desc").page(params[:page]).per(blog.first.pageable.max)
    end
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
