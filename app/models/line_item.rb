class LineItem < ActiveRecord::Base

  attr_accessible :cart_id, :product_id, :quantity

validates :quantity,
    :numericality => { :greater_than => 0 }

  belongs_to :product

  belongs_to :cart

end
