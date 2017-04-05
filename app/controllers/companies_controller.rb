class CompaniesController < ApplicationController
  before_action :set_company_by_slug, only: [:show, :sitemap, :paging, :article, :search]
  before_action :load_pages, only: [:show, :paging, :article, :search]
  before_action :add_views_path, only: [:show, :paging, :article, :search]

  def tag
    set_meta_tags title: 'Coloque suas idéias em prática!',
    description: "Resultados da busca de IDÉIAS por tag #{params[:tag]}"

    @tag = ActsAsTaggableOn::Tag.where(name: params[:tag]).first
    @companies = Company.search(params[:key]).tagged_with(params[:tag]).order('premium desc, logotipo desc').page(params[:page])
  end

  def sitemap
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
    load_articles
    filter_pages

    set_meta_tags description: @company.description
    @contact = Contact.new

    render layout: @company.profile.layout_path
  end

  def paging
    if @page.nil?
      not_found
    else
      load_articles
      set_meta_tags description: @company.description
      @contact = Contact.new

      render :show, layout: @company.profile.layout_path
    end
  end

  def article
    @page = @pages.find_by_slug(params[:paging])
    @article = @company.articles.find_by_slug(params[:article])

    if @article.nil? || @page.nil?
      not_found
    else
      set_meta_tags title: "#{@article.title} - #{@page.title}",
                    description: "#{@article.description}"

      render layout: @company.profile.layout_path
    end
  end

  def search
    @page = @pages.find_by_slug(params[:paging])
    @articles = @company.articles.search(params[:key]).page(params[:page])

    set_meta_tags title: "#{@page.title} - #{@page.description}",
                  description: "Termos de busca de artigos: #{params[:key]}"

    render layout: @company.profile.layout_path
  end

private

  def add_views_path
    self._view_paths.paths.reject! do |path|
      Profile.layout_list.map{|p| "app/views/layouts/themes/#{p}"}.include? path
    end

    new_path = "app/views/#{@company.profile.layout_path}"
    self._view_paths.paths << new_path
    self._view_paths.paths.uniq!
  end

  def set_company_by_slug
    @company = Company.find_by_slug(params[:slug])

    if @company.nil?
      not_found
    else
      @template = @company.profile.template
    end
  end

  def load_pages
    @pages = @company.profile.pages.order(:index)

    if params[:paging]
      @page = @pages.find_by_slug(params[:paging])
    else
      @page = @pages.first
    end
  end

  def filter_pages
    if @company.profile.layout != "landing"
      @pages = @pages.reject { |p| p.pageable_type == "LandingPage" }
    end
  end

  def load_articles
    blog = @pages.select{|a| a.pageable_type == "BlogPage" }
    unless blog.blank?
      # @articles = @company.articles.search(params[:key]).order("id desc").page(params[:page]).per(blog.first.pageable.max)
      @articles = Kaminari.paginate_array(@company.articles.search(params[:key]).order("id desc").to_a).page(params[:page]).per(blog.first.pageable.max)
    end
  end
end
