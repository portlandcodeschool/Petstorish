class OrdersController < ApplicationController

  def create

    cart = current_cart

    Stripe::Charge.create(
      :amount      => cart.total_cents,
      :card        => params[:stripeToken],
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @order = Order.new(:user_id => 1, :status => 'paid', :cart => cart)

    if @order.save
      flash[:notice] = "Your order has been placed."
      redirect_to cart_receipt_path
    else
      flash[:notice] = "There was a problem placing your order. Please try again."
      redirect_to cart_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to cart_path
  end

  def receipt
  end

end
