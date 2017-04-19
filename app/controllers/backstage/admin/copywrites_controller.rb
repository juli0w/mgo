module Backstage
  module Admin
    class CopywritesController < Backstage::Admin::ApplicationController
      before_filter :set_copywrite, only: [:edit, :update, :destroy]

      def index
        @copywrites = Copywrite.all.page(params[:page])
      end

      def new
        @copywrite = Copywrite.new
      end

      def create
        @copywrite = Copywrite.new(copywrite_params)

        if @copywrite.save
          flash[:success] = "Copy criada!"
          redirect_to backstage_admin_copywrites_path
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :new
        end
      end

      def edit
      end

      def update
        if @copywrite.update(copywrite_params)
          flash[:success] = "Salvo com sucesso!"
          redirect_to [:edit, :backstage, :admin, @copywrite]
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :edit
        end
      end

      def destroy
        @copywrite.delete

        flash[:success] = "Copy removida"
        redirect_to backstage_admin_copywrites_path
      end

    private

      def set_copywrite
        @copywrite = Copywrite.find(params[:id])
      end

      def copywrite_params
        params.require(:copywrite).permit(:name, :template)
      end
    end
  end
end
