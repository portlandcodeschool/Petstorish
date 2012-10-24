class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price
  attr_accessible :name, :description, :price
end
