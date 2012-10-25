class Option < ActiveRecord::Base
  attr_accessible :class, :product_id, :value
  validates_presence_of :class, :product_id, :value
  
  belongs_to :product


end
