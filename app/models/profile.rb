class Profile < ApplicationRecord
  belongs_to :company
  has_one :template, dependent: :destroy
  accepts_nested_attributes_for :template

  mount_uploader :cover, CoverUploader

  delegate :color, to: :template
  delegate :color_sample, to: :template

  [:primary_color, :detail_color, :link_color,
   :text_color, :logo_color, :description_color].each do |method|
     define_method(method) do

     end
   end
end
