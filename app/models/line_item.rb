class LineItem < ActiveRecord::Base

  attr_accessible :cart_id, :product_id, :quantity, :options

validates :quantity,
    :numericality => { :greater_than => 0 }

  belongs_to :product

  belongs_to :cart

  has_many :selected_options

end
