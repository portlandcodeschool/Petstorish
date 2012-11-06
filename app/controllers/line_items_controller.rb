class LineItemsController < ApplicationController

  def create
    @cart = current_cart # This method is defined in ApplicationController
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, params[:line_item])
    @line_item.product = product

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_path, notice: "The item was added to your cart, woohoo!" }
      else
        format.html {
          flash[:errors] = @line_item.errors.messages
          redirect_to product }
      end
    end

  end

  def update
    @line_item = LineItem.find(params[:id])
    if @line_item.update_attributes(params[:line_item])
      flash[:notice] = "Cart updated successfully.  (we think)"
    else
      flash[:errors] = @line_item.errors.messages
    end
    redirect_to cart_path


  end
end
