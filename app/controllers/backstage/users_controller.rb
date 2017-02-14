module Backstage
  class UsersController < Backstage::ApplicationController
    before_filter :set_user, only: [:edit, :update, :destroy]
    before_action :authenticate_admin!

    def index
      if params[:keyword].present?
        @users = User.where("email LIKE ?", "%#{params[:keyword]}%").page(params[:page])
      else
        @users = User.page params[:page]
      end
    end

    def become
      # return unless current_user.is_an_admin?
      sign_in(:user, User.find(params[:id]))
      redirect_to root_url
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:success] = "Usuário criado!"
        redirect_to backstage_users_path
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :new
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Salvo com sucesso!"
        redirect_to [:edit, :backstage, @user]
      else
        flash.now[:alert] = "Por favor verifique os campos."
        render :edit
      end
    end

    def destroy
      @user.delete

      flash[:success] = "Usuário removido"
      redirect_to backstage_users_path
    end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
