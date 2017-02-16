module Backstage
  class SubscribesController < Backstage::ApplicationController
    def index
      @subscribes = current_user.subscribes.page(params[:page])
    end

    def create
      @subscribe = current_user.subscribes.new(subscribe_params)
      @subscribe.state = 0

      if @subscribe.save
        flash[:success] = "Sua empresa será ativada assim que o pagamento for confirmado!"
        redirect_to backstage_subscribe_path(@subscribe)
      else
        @companies = current_user.companies
        @plans = Subscribe::PLANS_PRICE
        flash.now[:error] = "Preencha os campos corretamente."
        render :new
      end
    end

    def show
      @subscribe = current_user.subscribes.find(params[:id])
    end

    def new
      @subscribe = current_user.subscribes.new(plan: params[:plan])
      @companies = current_user.companies
      @plans = Subscribe::PLANS_PRICE
    end

  private

    def subscribe_params
      params.require(:subscribe).permit(:company_id, :plan)
    end
  end
end
