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

  def color_sample input, company, text=false, force=true
    color = send(input, company, text, true)
    content_tag :span, "", class: "color-sample open-color-group #{color}", input: input
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

  [:primary_color, :detail_color, :link_color, :text_color,
   :logo_color, :description_color].each do |method|
     define_method(method) do |company, text=false, force=false|
       color = company.color(method, force)

       return color.gsub("-text", "").gsub("text-", "") if text
       return color
     end
  end

  def header_image company
    image = company.profile.cover.url || '/images/bg-header.jpg'
    "background-image: url('#{image}');"
  end
end
