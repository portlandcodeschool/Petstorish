class Cart < ActiveRecord::Base

  attr_accessible :line_items

  has_many :line_items, dependent: :destroy


  def add_product(product_id, quantity, options_hash)

    current_item = line_items.find_by_product_id(product_id)

    if current_item 
      
      options1 = []
      line_items.options.each do |option|
        options1 << option.id
      end
      options1.sort!

      options2 = []
      options_hash.each_value do |option_id|
        options2 << option_id
      end
      options2.sort!

      if options1 == options2
        new_quantity = current_item.quantity + quantity 
        current_item.update_attributes(:quantity => new_quantity)
      else
        current_item = line_items.build(line_item)
        options_hash.each_value do |option_id|
          current_item.selected_options.build(:option_id => option_id)
        end
      end 
    else
      current_item = line_items.build(line_item)

      options_hash.each_value do |option_id|
        current_item.selected_options.build(:option_id => option_id)
      end
    end



    current_item

  end


end
