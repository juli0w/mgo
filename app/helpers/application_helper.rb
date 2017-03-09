module ApplicationHelper
  def alert_for(title)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[title.to_sym] || title.to_s
  end
  def title_for(title)
    { success: 'Woohoo',
      error: 'Oops',
      alert: 'Hey',
      notice: 'Informação'
    }[title.to_sym] || title.to_s
  end

  def odd_color company, n
    "#{color(:primary_color, company)} #{color(:text_color, company)}" unless n.odd?
  end

  def color_sample input, company
    c = company.color_sample(input)
    content_tag(:div, "",
      class: "color-sample tooltipped open-color-group #{c}", id: "cs-#{input}", input: input,
      'data-delay': 50, 'data-tooltip': c)
  end

  def color input, company, force=false
    company.color(input, force)
  end

  def slider company
    return "" unless company.logotipo
    company.logotipo.try(:slider).try(:url) || ""
  end

  def logotipo company
    return "/images/sem-imagem.png" unless company.logotipo.thumb
    company.logotipo.thumb.try(:url) || "/images/no-image.gif"
  end

  def logotipo_square company
    return "/images/sem-imagem.png" unless company.logotipo.square
    company.logotipo.square.try(:url) || "/images/no-image.gif"
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def get_url company
    company.slug.nil? ? company_path(company) : "#{root_url}#{company.slug}"
  end

  def rate_for company
    content = ""
    (1..5).each do |n|
      content += content_tag(:span, "", class: "star #{'fullStar' if company.note >= n}")
    end

    return content.html_safe
  end

  def header_image company
    image = company.profile.cover.url || '/images/bg-header.jpg'
    "background-image: url('#{image}');"
  end
end
