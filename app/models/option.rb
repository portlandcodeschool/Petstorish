class Option < ActiveRecord::Base
  attr_accessible :family, :value, :option_assignments
  validates_presence_of :family, :value

  has_many :option_assignments
  has_many :products, :through => :option_assignments

  def self.optionData
    allOptions = Option.all
    families = allOptions.collect(&:family).uniq.sort
    return [families, allOptions]
  end
end
