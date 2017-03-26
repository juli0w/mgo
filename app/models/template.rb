class Template < ApplicationRecord
  belongs_to :profile, optional: :true
  belongs_to :sample_template, optional: :true
  belongs_to :primary_color, class_name: "Color", optional: true#, :foreign_key => 'primary_color'
  belongs_to :description_color, class_name: "Color", optional: true#, :foreign_key => 'primary_color'
  belongs_to :detail_color, class_name: "Color", optional: true#, :foreign_key => 'detail_color'
  belongs_to :link_color, class_name: "Color", optional: true#, :foreign_key => 'link_color'
  belongs_to :text_color, class_name: "Color", optional: true#, :foreign_key => 'text_color'
  belongs_to :logo_color, class_name: "Color", optional: true#, :foreign_key => 'logo_color'

  after_initialize :set_default

  delegate :company, to: :profile

  DEFAULT_COLOR = { primary_color: Color.find_by_name("grey darken-3"),
                    detail_color: Color.find_by_name("amber"),
                    link_color: Color.find_by_name("amber"),
                    text_color: Color.find_by_name("white"),
                    logo_color: Color.find_by_name("grey darken-3"),
                    description_color: Color.find_by_name("grey darken-3") }

  def set_default
    self.primary_color ||= DEFAULT_COLOR[:primary_color]
    self.description_color ||= DEFAULT_COLOR[:description_color]
    self.link_color ||= DEFAULT_COLOR[:link_color]
    self.text_color ||= DEFAULT_COLOR[:text_color]
    self.logo_color ||= DEFAULT_COLOR[:logo_color]
    self.detail_color ||= DEFAULT_COLOR[:detail_color]
  end

  def color_sample field
    c = send(field)
    c.name
  end

  def color field, force=false
    c = send(field)

    if (company.premium? or force)
      result = c.name
    else
      result = DEFAULT_COLOR[field].name
    end

    text_field?(field) ? textilize(result) : result
  end

  def text_field? field
    field.to_s != "primary_color"
  end

  def textilize color
    main = "#{color.split(" ")[0]}-text"
    desc = "text-#{color.split(" ")[1]}" if color.split(" ")[1].present?
    "#{main} #{desc if desc.present?}"
  end
end
