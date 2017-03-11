module Backstage
  class AlbumPagesController < Backstage::ApplicationController
    before_filter :set_page
    before_filter :set_album_page

    def edit
      redirect_to [:backstage, @company, @page, @album_page, :photos]
    end

  private

    def set_page
      @company = current_user.companies.find(params[:company_id])
      @page = @company.profile.pages.find(params[:page_id])
    end

    def set_album_page
      @album_page = @page.pageable
    end

    def album_page_params
      params.require(:album_page).permit(:content)
    end
  end
end
