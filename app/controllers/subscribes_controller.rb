class SubscribesController < ApplicationController
  layout 'promotion'
  before_action :authenticate_user!, only: [:apply, :create]

  def new
    @subscribe = Subscribe.new
  end

  def create
    @subscribe = current_user.subscribes.new(subscribe_params)

    if @subscribe.save
      flash[:success] = "Seus dados foram salvos, entraremos em contato em breve"
      redirect_to partner_path
    else
      flash.now[:error] = "Preencha os campos corretamente."
      render :new
    end
  end

  def apply
    @subscribe = current_user.subscribes.new(plan: params[:plan])
    render layout: 'backstage'
  end

private

  def subscribe_params
    params.require(:subscribe).permit(:name, :email, :phone, :plan)
  end
end
