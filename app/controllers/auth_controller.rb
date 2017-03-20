class AuthController < ApplicationController
  def login
    if user_signed_in?
      redirect_to after_sign_in_path_for(:user)
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.js
      end
    end
  end

  def register
    if user_signed_in?
      redirect_to after_sign_in_path_for(:user)
    else
      respond_to do |format|
        format.html { redirect_to new_user_registration_path }
        format.js
      end
    end
  end
end
