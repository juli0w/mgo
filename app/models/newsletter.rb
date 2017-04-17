class Newsletter < ApplicationRecord
  belongs_to :company
  has_one :template, dependent: :destroy
  accepts_nested_attributes_for :template

  delegate :color_sample, to: :template
  delegate :color, to: :template
end
