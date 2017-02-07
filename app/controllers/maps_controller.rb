class MapsController < ApplicationController
  before_filter :set_noindex, only: [:resources]
  layout 'map'

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
    set_map
    render json: @map.to_json
  end

private

  def set_map
    @map = Map.all.map { |m| [m.company.name, m.lat, m.lng,
                              m.company.profile.formatted_address,
                              "/#{m.company.slug}",
                              m.company.note] }
  end
end
