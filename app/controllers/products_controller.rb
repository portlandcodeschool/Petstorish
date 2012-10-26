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
      flash[:notice] = "Oops, there was a problem - please try again."
      redirect_to :action => "new"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "SUPER DUPER success"
      redirect_to @product
    else
      flash[:notice] = "Oops, there was a problem - please try again."
      render :action => :edit
    end
  end

  def delete
    @product = Product.find(params[:id])
  end

end
