class Option < ActiveRecord::Base
  attr_accessible :family, :value, :option_assignments
  validates_presence_of :family, :value

  has_many :option_assignments
  has_many :products, :through => :option_assignments

  before_validation :strip_blanks


  def strip_blanks
    self.family = self.family.strip
    self.value = self.value.strip
  end
end
