module Backstage
  class BlogPagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_blog_page

    def edit
    end

    def update
      if @blog_page.update(blog_page_params)
        flash[:success] = "Página modificada com sucesso!"
        redirect_to [:backstage, @company, :pages]
      else
        flash.now[:alert] = "Por favor verifique os campos"
        render :new
      end
    end

  private

    def set_page
      @company = current_user.companies.find(params[:company_id])
      @page = @company.profile.pages.find(params[:page_id])
    end

    def set_blog_page
      @blog_page = @page.pageable
    end

    def blog_page_params
      params.require(:blog_page).permit(:max)
    end
  end
end
