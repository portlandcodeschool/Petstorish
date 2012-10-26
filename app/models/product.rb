class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price, :category
  attr_accessible :name, :description, :price, :image, :category
  has_attached_file :image

  validates :price, 
    :numericality => { :greater_than => 0 },
    :format => { :with => /^(\d+)?\.?\d?\d?$/ }

  def self.categories 
    %w[one two pets]
  end
end
