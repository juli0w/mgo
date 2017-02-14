module Backstage
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'backstage'
    before_action :authenticate_user!
    before_filter :set_noindex

  private

    def authenticate_admin!
      return true if current_user.admin?

      flash[:alert] = "Você não é administrador"
      redirect_to backstage_companies_path
    end

    def set_noindex
      set_meta_tags noindex: true
    end
  end
end
