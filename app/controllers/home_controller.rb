class HomeController < ApplicationController
  def index
    set_meta_tags title: 'Principais locais e eventos da região',
    description: 'O Weekz reúne diversos locais para quem está buscando algo para fazer na região, seja para lazer ou profissional.'

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
    set_meta_tags title: 'Resultados para sua busca',
                  description: 'O Weekz reúne diversos locais para quem está buscando algo para fazer na região, seja para lazer ou profissional.'

    @companies = Company.search(params[:key]).order('premium desc, logotipo desc').page(params[:page])
    # @companies = SearchFilter.new.filter(Company.all, params[:key]).page(params[:page])
    # @companies = Company.search(params.permit(:key)).page(params[:page])
  end

  def contact
    set_meta_tags title: 'Página de Contato',
                  description: 'Deixe-nos uma mensagem!'
    @contact = Contact.new(destination: admin_email)
  end
end
