class OptionAssignment < ActiveRecord::Base
  attr_accessible :option_id, :product_id, :product, :option
  validates_presence_of :option_id, :product_id

  belongs_to :product
  belongs_to :option

end
