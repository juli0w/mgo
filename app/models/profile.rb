class Profile < ApplicationRecord
  belongs_to :company
  belongs_to :font, optional: true
  has_many :pages
  has_one :template, dependent: :destroy
  accepts_nested_attributes_for :template

  LAYOUTS = [["Padrão", "default"],
             ["Full Page", "full"]]

  mount_uploader :cover, CoverUploader

  delegate :color, to: :template
  delegate :color_sample, to: :template

  def font
    f = super
    f.blank? ? Font.last : f
  end

  [:primary_color, :detail_color, :link_color,
   :text_color, :logo_color, :description_color].each do |method|
     define_method(method) do

     end
   end
end
