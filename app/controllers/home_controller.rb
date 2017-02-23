class HomeController < ApplicationController
  def index
    set_meta_tags title: 'Procurou, achou!',
                  description: 'Página inicial'

    @destaque = Company.premium.last(8)
    @dia = Company.by_tag('dia').first(5)
    @noite = Company.by_tag('noite').first(5)
    @natureza = Company.by_tag('natureza').first(5)

    # @offers = Offer.offers
    @map = true
  end

  def institutional
  end

  def search
    set_meta_tags title: 'Busca',
                  description: 'Página de busca de empresas'

    @companies = Company.search(params[:key]).page(params[:page])
    # @companies = SearchFilter.new.filter(Company.all, params[:key]).page(params[:page])
    # @companies = Company.search(params.permit(:key)).page(params[:page])
  end

  def contact
    set_meta_tags title: 'Contato',
                  description: 'Página de contato'
    @contact = Contact.new(destination: admin_email)
  end
end
