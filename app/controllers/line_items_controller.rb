class LineItemsController < ApplicationController

def create
  @cart = current_cart # This method is defined in ApplicationController
  product = Product.find(params[:product_id])
  @line_item = @cart.line_items.build(params[:line_item])
  @line_item.product = product

  respond_to do |format|
    if @line_item.save
      format.html { redirect_to @line_item.cart, notice: "The item was added to your cart, woohoo!" }
    else
      format.html {
        flash[:errors] = @line_item.errors.messages
        redirect_to product }
    end
  end

end

end