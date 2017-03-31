class HomeController < ApplicationController
  def index
    set_meta_tags title: 'Coloque suas idéias em prática!',
    description: 'O Weekz reúne diversas idéias para te ajudar a encontrar o que você está procurando ou para alavancar sua idéia na internet.'

    @last_articles = Article.last(6)

    @callaction = user_signed_in? ? backstage_companies_path : register_path

    load_destaques
  end

  def institutional
  end

  def sitemap
    @companies = Company.premium
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml { render layout: nil }
    end
  end

  def sitemap_index
    @companies = Company.premium
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml { render layout: nil }
    end
  end

  def search
    set_meta_tags title: "Busca de IDÉIAS: #{params[:key]}",
    description: 'O Weekz reúne diversas idéias para te ajudar a encontrar o que você está procurando ou para alavancar sua idéia na internet.'

    @companies = Company.search(params[:key]).order('premium desc, logotipo desc').page(params[:page])

    if @companies.empty?
      not_found
      return
    end
  end

  def contact
    set_meta_tags title: 'Coloque suas idéias em prática!',
                  description: 'Deixe-nos uma mensagem! Queremos te ajudar com as suas idéias.'
    @contact = Contact.new(destination: admin_email)
  end

  def robots
    @companies = Company.all

    render 'robots.txt.erb', layout: false, content_type: 'text/plain'
  end
end
