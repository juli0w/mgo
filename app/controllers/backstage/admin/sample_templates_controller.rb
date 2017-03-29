module Backstage
  module Admin
    class SampleTemplatesController < Backstage::Admin::ApplicationController
      before_filter :set_sample_template, only: [:edit, :update, :destroy]
      before_action :authenticate_admin!, except: [:show]

      def index
        @sample_templates = SampleTemplate.all
      end

      def show
        @sample_template = SampleTemplate.find(params[:id])

        render json: @sample_template.template.to_json(:include => [:primary_color,
                                                                    :detail_color,
                                                                    :text_color,
                                                                    :link_color,
                                                                    :logo_color,
                                                                    :description_color])
      end

      def new
        @sample_template = SampleTemplate.new
        @template = @sample_template.create_template
      end

      def create
        @sample_template = SampleTemplate.new(sample_template_params)

        if @sample_template.save
          flash[:success] = "Template criado!"
          redirect_to backstage_admin_sample_templates_path
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :new
        end
      end

      def edit
        @template = @sample_template.template || @sample_template.create_template
      end

      def update
        if @sample_template.update(sample_template_params)
          flash[:success] = "Salvo com sucesso!"
          redirect_to backstage_admin_sample_templates_path
        else
          flash.now[:alert] = "Por favor verifique os campos."
          render :edit
        end
      end

      def destroy
        @sample_template.delete

        flash[:success] = "Template removido"
        redirect_to backstage_admin_sample_templates_path
      end

    private

      def set_sample_template
        @sample_template = SampleTemplate.find(params[:id])
      end

      def sample_template_params
        params.require(:sample_template).permit(:name,
          template_attributes: [:primary_color_id, :detail_color_id, :text_color_id, :link_color_id,
                                :logo_color_id, :description_color_id])
      end
    end
  end
end
