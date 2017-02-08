class HomeController < ApplicationController
  def index
    set_meta_tags title: 'Procurou, achou!',
                  description: 'Página inicial'

    @companies = if params[:tag]
      Company.tagged_with(params[:tag]).page(params[:page])
    else
      Company.all.page(params[:page]).per(5)
    end

    @map = true
  end

  def institutional
  end

  def search
    set_meta_tags title: 'Busca',
                  description: 'Página de busca de empresas'
    @companies = Company.search(params.permit(:key)).page(params[:page])
  end

  def contact
    set_meta_tags title: 'Contato',
                  description: 'Página de contato'
    @contact = Contact.new(destination: admin_email)
  end
end
