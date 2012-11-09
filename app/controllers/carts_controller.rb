class CartsController < ApplicationController


  def edit
    @cart = current_cart

    if @cart.line_items.empty?
      flash[:notice] = "Your cart is empty.  Go buy stuff or the terrorists win."
    end

  end

  def checkout
    @cart = current_cart
    if @cart.line_items.empty?
      flash[:notice] = "Your cart is empty.  Go buy stuff or the terrorists win."
    end
  end

end
