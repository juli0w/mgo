class SampleTemplate < ApplicationRecord
  has_one :template, dependent: :destroy
  accepts_nested_attributes_for :template
  
  delegate :color_sample, to: :template
end
