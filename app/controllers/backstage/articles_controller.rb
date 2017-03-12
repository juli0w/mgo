module Backstage
  class ArticlesController < Backstage::ApplicationController
    before_filter :set_company
    before_filter :set_article, only: [:edit, :update, :destroy]

    def index
      @articles = @company.articles.order('ID desc').page(params[:page])
    end

    def new
      @article = @company.articles.new
    end

    def create
      @article = @company.articles.new(article_params)

      if @article.save
        flash[:success] = "Artigo criado!"
        redirect_to backstage_company_articles_path(@company)
      else
        flash.now[:alert] = "Por favor verifique os campos"
        render :new
      end
    end

    def edit
    end

    def update
      if @article.update(article_params)
        flash[:success] = "Artigo atualizado"
        redirect_to [:edit, :backstage, @company, @article]
      else
        flash.now[:alert] = "Por favor verifique os campos"
        render :new
      end
    end

    def destroy
      @article.destroy

      flash[:success] = "Artigo deletado com sucesso!"
      redirect_to backstage_company_articles_path(@company)
    end

  private

    def set_company
      @company = current_user.companies.find(params[:company_id])
    end

    def set_article
      @article = @company.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :cover, :description, :slug, :content)
    end
  end
end
