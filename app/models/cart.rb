class Cart < ActiveRecord::Base

  attr_accessible :line_items

  has_many :line_items, dependent: :destroy


  def add_product(product_id, line_item)

    current_item = line_items.find_by_product_id(product_id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(line_item)
    end

    current_item

  end


end
