module Backstage
  module Admin
    class UsersController < Backstage::Admin::ApplicationController
      before_filter :set_user, only: [:edit, :update, :destroy]

      def index
        if params[:keyword].present?
          @users = User.where("email LIKE ?", "%#{params[:keyword]}%").page(params[:page])
        else
          @users = User.page params[:page]
        end
      end

      def become
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
          redirect_to backstage_admin_users_path
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
          redirect_to [:edit, :backstage, :admin, @user]
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :edit
        end
      end

      def destroy
        @user.delete

        flash[:success] = "Usuário removido"
        redirect_to backstage_admin_users_path
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
end
