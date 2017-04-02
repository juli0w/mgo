class Profile < ApplicationRecord
  belongs_to :company
  belongs_to :font, optional: true
  has_many :pages, dependent: :destroy
  has_one :template, dependent: :destroy
  accepts_nested_attributes_for :template

  LAYOUTS = [["Padrão", "default"],
             ["Full Page", "full"],
             ["Landing Page", "landing"]]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :cover, CoverUploader

  delegate :color, to: :template
  delegate :color_sample, to: :template

  def layout_path path=nil
    layout = "layouts/themes/#{self.layout}"
    layout = "#{layout}/#{path.to_s}" if path
    return layout
  end

  def font
    f = super
    f.blank? ? Font.first : f
  end
end
