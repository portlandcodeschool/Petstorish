class OrdersController < ApplicationController

  def list

  end

  def search

  end

  def index
    @orders = Order.all
  end

  def show

  end

  def new
  end

  def create
    
    Stripe::Charge.create(
      :amount      => params[:amount],
      :card        => params[:stripeToken],
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
  
    @order = Order.new(params[:order])
    
    if @order.save
      flash[:notice] = "Your order has been placed."
      redirect_to :action => "index"
    else
      flash[:notice] = "There was a problem placing your order. Please try again."
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end




  def edit
  end

  def update
  end

  def delete
  end


end
