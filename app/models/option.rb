class Option < ActiveRecord::Base
  attr_accessible :family, :value, :option_assignments
  validates_presence_of :family, :value
  validates_uniqueness_of :family, :scope => [:value]
  has_many :option_assignments
  has_many :products, :through => :option_assignments

  #to strip whitespace
  before_validation :strip_blanks

  #the method that does the stripping
  protected
  def strip_blanks
    if self.value
      self.value = self.value.strip
    end
    if self.family
      self.family = self.family.strip
    end
  end

  def self.optionData
    allOptions = Option.all
    families = allOptions.collect(&:family).uniq.sort
    return [families, allOptions]
  end
end
