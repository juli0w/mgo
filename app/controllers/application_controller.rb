class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_variables
  before_action :store_current_location, :unless => :devise_controller?
  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/login" &&
        request.path != "/sign_up" &&
        request.path != "/logout" &&
        !request.xhr?) # don't store ajax calls
      if request.format == "text/html" || request.content_type == "text/html"
        session[:previous_url] = request.fullpath
        session[:last_request_time] = Time.now.utc.to_i
      end
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

private

  def admin_email
    "juli0w@hotmail.com"
  end

  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
  end

  # Or if you need to blacklist for some reason
  def after_sign_in_path_for(resource)
    blacklist = [new_user_session_path, new_user_registration_path] # etc...
    last_url = session["user_return_to"]
    if blacklist.include?(last_url)
      root_path
    else
      last_url
    end
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def set_noindex
    set_meta_tags noindex: true
  end

  def set_variables
    @categories ||= Category.root.order(:name)
    @page_keywords = "empreender, joinville, anunciar, marketing digital, independencia, serviços"
  end
end
