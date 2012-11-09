class Cart < ActiveRecord::Base

  attr_accessible :line_items

  has_many :line_items, dependent: :destroy


  def add_product(product_id, quantity, options_hash)

    current_items = line_items.find_all_by_product_id(product_id)

    current_items.each do |current_item|
      options1 = []
      current_item.selected_options.each do |option|
        options1 << option.option_id
      end
      options1.sort!

      options2 = []

      (options_hash || {}).each_value do |option_id|
        options2 << option_id.to_i
      end
      options2.sort!

      if options1 == options2
        new_quantity = current_item.quantity + quantity
        current_item.update_attributes(:quantity => new_quantity)
        return current_item
      end

    end

    current_item = line_items.build(:product_id => product_id, :quantity => quantity)

    (options_hash || {}).each_value do |option_id|
      current_item.selected_options.build(:option_id => option_id)
    end

    current_item

  end

  # Total price for the order
  def total
    sum = 0
    self.line_items.each do |item|
      sum += item.product.price * item.quantity
    end
    sum
  end

  def total_cents
    (100 * self.total).to_i
  end

end
