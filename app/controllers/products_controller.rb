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
    @product = Product.find(params[:id])

  end
  def update
  end
  def delete
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    @product.save
    flash[:notice] = "SUPER DUPER success"
    redirect_to @product

    # redirect_to :controller => :products, :action => :show
  end

end
