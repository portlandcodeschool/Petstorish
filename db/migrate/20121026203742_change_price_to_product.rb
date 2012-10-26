class ChangePriceToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :price
    add_column :products, :price, :decimal, :precision => 5, :scale => 2
  end
end
