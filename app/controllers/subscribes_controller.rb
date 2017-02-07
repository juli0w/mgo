class SubscribesController < ApplicationController
  layout 'promotion'

  def new
    @subscribe = Subscribe.new
  end

  def create
    @subscribe = Subscribe.new(subscribe_params)

    if @subscribe.save
      flash[:success] = "Seus dados foram salvos, entraremos em contato em breve"
      redirect_to partner_path
    else
      flash.now[:error] = "Preencha os campos corretamente."
      render :new
    end
  end

private

  def subscribe_params
    params.require(:subscribe).permit(:name, :email, :phone, :plan)
  end
end
