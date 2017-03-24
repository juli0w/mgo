class HomeController < ApplicationController
  def index
    set_meta_tags title: 'Encontre empreendimentos. Avalanque sua idéia.',
    description: 'Portal de empreendimentos para você encontrar o que precisa na sua região e alavancar o seu negócio'

    load_destaques
  end

  def institutional
  end

  def sitemap
    @companies = Company.all
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml { render layout: nil }
    end
  end

  def sitemap_index
    @companies = Company.all
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml { render layout: nil }
    end
  end

  def search
    set_meta_tags title: "Busca de empreendimentos: #{params[:key]}",
                  description: 'Portal de empreendimentos para você encontrar o que precisa na sua região e alavancar o seu negócio'

    @companies = Company.search(params[:key]).order('premium desc, logotipo desc').page(params[:page])

    if @companies.empty?
      not_found
      return
    end
  end

  def contact
    set_meta_tags title: 'Área de contato',
                  description: 'Deixe-nos uma mensagem! Queremos expandir seu negócio'
    @contact = Contact.new(destination: admin_email)
  end

  def robots
    @companies = Company.all

    render 'robots.txt.erb', layout: false, content_type: 'text/plain'
  end
end
