class HomeController < ApplicationController
  def index
    set_meta_tags title: 'Encontre empreendimentos. Avalanque sua idéia.',
    description: 'Portal de empreendimentos para você encontrar o que precisa na sua região e alavancar o seu negócio'

    @destaque = Company.premium.last(8)
    # @map = true
    # expires_in 5.minutes, public: true
  end

  def institutional
  end

  def search
    set_meta_tags title: "Busca de empreendimentos: #{params[:key]}",
                  description: 'Portal de empreendimentos para você encontrar o que precisa na sua região e alavancar o seu negócio'

    @companies = Company.search(params[:key]).order('premium desc, logotipo desc').page(params[:page])
    # @companies = SearchFilter.new.filter(Company.all, params[:key]).page(params[:page])
    # @companies = Company.search(params.permit(:key)).page(params[:page])
  end

  def contact
    set_meta_tags title: 'Área de contato',
                  description: 'Deixe-nos uma mensagem! Queremos expandir seu negócio'
    @contact = Contact.new(destination: admin_email)
  end
end
