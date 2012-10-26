class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price, :category
  attr_accessible :name, :description, :price, :image, :category
  has_attached_file :image
end
