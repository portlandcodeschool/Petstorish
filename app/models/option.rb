class Option < ActiveRecord::Base
  attr_accessible :family, :value, :option_assignments
  validates_presence_of :family, :value

  has_many :option_assignments
  has_many :products, :through => :option_assignments

end
