module Backstage
  module Admin
    class CategoriesController < Backstage::Admin::ApplicationController
      before_filter :set_category, only: [:edit, :update, :destroy]

      def index
        if params[:keyword].present?
          @categories = Category.where("name LIKE ?", "%#{params[:keyword]}%").page(params[:page])
        else
          @categories = Category.page params[:page]
        end
      end

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          flash[:success] = "Categoria criada!"
          redirect_to backstage_admin_categories_path
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :new
        end
      end

      def edit
      end

      def update
        if @category.update(category_params)
          flash[:success] = "Salvo com sucesso!"
          redirect_to backstage_admin_categories_path
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :edit
        end
      end

      def destroy
        @category.delete

        flash[:success] = "Categoria removida"
        redirect_to backstage_admin_categories_path
      end

    private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :ancestor_id)
      end
    end
  end
end
