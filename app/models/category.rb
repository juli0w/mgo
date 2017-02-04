class Category < ApplicationRecord
  paginates_per 10

  has_many :companies
  has_many :children, :class_name => "Category", :foreign_key => "ancestor_id", :dependent => :destroy
  belongs_to :ancestor, :class_name => "Category", optional: true

  def self.root
    where(ancestor_id: nil)
  end

  def root?
    ancestor_id == nil
  end
end
