class MapsController < ApplicationController
  before_filter :set_noindex, only: [:resources]

  def index
    set_meta_tags title: 'Procurou, achou!',
                  description: 'Página inicial'

    @companies = if params[:tag]
      Company.tagged_with(params[:tag]).page(params[:page])
    else
      Company.all.page(params[:page])
    end
  end

  def resources
    set_map params[:category]
    render json: @map.to_json
  end

private

  def set_map category_id
    if category_id.present?
      @map = Map.all.select { |m| m.company.category_id == category_id.to_i }.
                        map { |m| [m.company.name, m.lat, m.lng,
                                m.company.try(:formatted_address),
                                "/#{m.company.slug}",
                                m.company.note] }
    else
      @map = Map.all.map { |m| [m.company.name, m.lat, m.lng,
                                m.company.try(:formatted_address),
                                "/#{m.company.slug}",
                                m.company.note] }
    end
  end
end
