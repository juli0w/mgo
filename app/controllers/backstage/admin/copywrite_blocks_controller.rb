module Backstage
  module Admin
    class CopywriteBlocksController < Backstage::Admin::ApplicationController
      before_filter :set_copywrite_block, only: [:show, :edit, :update, :destroy]

      def index
        @copywrite_blocks = CopywriteBlock.all.search(params[:key]).page(params[:page]).per(8)

        respond_to do |format|
          format.html
          format.csv do
            send_data @copywrite_blocks.to_csv
          end
        end
      end

      def import
        CopywriteBlock.import(params[:file])
        redirect_to backstage_admin_copywrite_blocks_path, notice: "Importação concluída."
      end

      def show
        @template = @copywrite_block.template
      end

      def new
        @copywrite_block = CopywriteBlock.new
      end

      def create
        @copywrite_block = CopywriteBlock.new(copywrite_block_params)

        if @copywrite_block.save
          flash[:success] = "Bloco criado!"
          redirect_to backstage_admin_copywrite_blocks_path
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :new
        end
      end

      def edit
      end

      def update
        if @copywrite_block.update(copywrite_block_params)
          flash[:success] = "Salvo com sucesso!"
          redirect_to [:edit, :backstage, :admin, @copywrite_block]
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :edit
        end
      end

      def destroy
        @copywrite_block.delete

        flash[:success] = "Bloco removido"
        redirect_to backstage_admin_copywrite_blocks_path
      end

    private

      def set_copywrite_block
        @copywrite_block = CopywriteBlock.find(params[:id])
      end

      def copywrite_block_params
        params.require(:copywrite_block).permit(:name, :template, :category)
      end
    end
  end
end
