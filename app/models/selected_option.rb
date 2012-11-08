class SelectedOption < ActiveRecord::Base
  attr_accessible :line_item_id, :option_id
  belongs_to :line_item
  belongs_to :option

end
