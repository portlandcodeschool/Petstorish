class ProductsController < ApplicationController

  def list

  end

  def search

  end


  def index
    @products = Product.all
  end

  def edit
  end
  def show
  end
  def update
  end
  def delete
  end

  def new
  end

  def create
    @product = Product.save
    redirect_to @product
    # redirect_to :controller => :products, :action => :show
  end

end
