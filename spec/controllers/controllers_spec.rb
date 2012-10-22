require 'spec_helper'

describe OrdersController do
  describe "GET index" do
    it "assigns all orders to @orders" do
      order = double("steve")
      Order.stub(:all) { order }
      get :index
      assigns(:orders).should eq(order)
    end
  end
end

describe ProductsController do
  describe "GET index" do
    it "assigns all products to @products" do
      product = double("steve")
      Product.stub(:all) { product }
      get :index
      assigns(:products).should eq(product)
    end
  end
end