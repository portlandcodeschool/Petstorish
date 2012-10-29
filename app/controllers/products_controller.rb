class ProductsController < ApplicationController

  def list

  end

  def search

  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(params[:product])
    if @product.save
      flash[:notice] = "SUPER DUPER success"
      redirect_to @product
    else
      flash[:errors] = @product.errors.messages
      redirect_to :action => "new"
    end
  end

  def edit

  end

  def update

  end

  def delete
    @product = Product.find(params[:id])
  end

end
