class Option < ActiveRecord::Base
  attr_accessible :family, :product_id, :value
  validates_presence_of :family, :product_id, :value
  
  belongs_to :product


end
