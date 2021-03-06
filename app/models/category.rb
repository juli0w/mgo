class Category < ApplicationRecord
  paginates_per 10

  has_many :companies
  has_many :children, :class_name => "Category", :foreign_key => "ancestor_id", :dependent => :destroy
  belongs_to :ancestor, :class_name => "Category", optional: true

  def self.root
    where(ancestor_id: nil)
  end

  def self.childs
    where.not(ancestor_id: nil)
  end

  def root?
    ancestor_id == nil
  end

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def self.except_root
    where.not(ancestor_id: nil)
  end
end
