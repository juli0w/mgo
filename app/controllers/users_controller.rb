class UsersController < ApplicationController
  layout 'backstage'
  before_filter :set_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :set_noindex, only: [:index, :new, :edit]

  def index
    @users = User.page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Usuário criado!"
      redirect_to users_path
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
      redirect_to [:edit, @user]
    else
      flash.now[:alert] = "Por favor verifique os campos."
      render :edit
    end
  end

  def destroy
    @user.delete

    flash[:success] = "Usuário removido"
    redirect_to users_path
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end