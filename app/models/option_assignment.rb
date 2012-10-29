class OptionAssignment < ActiveRecord::Base
  attr_accessible :option_id, :product_id, :product, :option
  
  belongs_to :product
  belongs_to :option

end
