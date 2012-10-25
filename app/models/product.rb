class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price
  attr_accessible :name, :description, :price, :image
  has_attached_file :image
end
