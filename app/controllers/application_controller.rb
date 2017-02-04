class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # rescue_from ::ActiveRecord::RecordNotFound, with: :error_occurred
  # rescue_from ::NameError, with: :error_occurred
  # rescue_from ::ActionController::RoutingError, with: :error_occurred

  before_filter :set_variables

private

  def error_occurred
    render "layouts/error", layout: 'application'
    return
  end

  def admin_email
    "juli0w@hotmail.com"
  end

  def set_noindex
    set_meta_tags noindex: true
  end

  def set_variables
    @categories ||= Category.root
    @page_keywords = "guia, busca, empresas, independencia, serviços"
  end
end
