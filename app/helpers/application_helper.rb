module ApplicationHelper
  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def slider company
    return "" unless company.logotipo
    company.logotipo.try(:slider).try(:url) || ""
  end

  def logotipo company
    return "" unless company.logotipo
    company.logotipo.try(:url) || ""
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

  def primary_color company
    company.profile.primary_color || 'light-green darken-4'
  end

  def detail_color company
    company.profile.detail_color || 'orange-text'
  end

  def link_color company
    company.profile.link_color || 'white-text'
  end

  def text_color company
    company.profile.text_color || 'white-text'
  end

  def logo_color company
    company.profile.logo_color || 'white-text'
  end

  def description_color company
    company.profile.description_color || 'white-text'
  end

  def description_color company
    company.profile.description_color || 'white-text'
  end

  def header_image company
    image = company.profile.cover.url || '/images/bg-header.jpg'
    "background-image: url('#{image}');"
  end
end
