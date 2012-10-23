require 'spec_helper'

describe ProductsController do
  let(:products) { [mock("product1"), mock("product2")] }
  let(:product) { mock("new_product", :model_name => "Product")}

  describe "GET index" do
    it "assigns all products to @products" do
      Product.stub(:all).and_return(products)
    end

    it "should select the products/index template for rendering" do
      Product.stub(:all).and_return(products)
      get :index
      response.should render_template('products/index')
    end

  end

  describe "creating a new product" do
    it "should call the new method on Product" do
      Product.stub(:new)
      #assert something here
    end

    it "should render the new template" do
      get :new
      response.should render_template('products/new')
    end

    context "successful save" do
      it "should redirect to the show template" do
        Product.stub(:save).and_return(product)
        Product.stub(:model_name).and_return("product")
        post :create
        response.should redirect_to('products/show')
        # response.should render_template('products/show')
      end
      it "should display a happy flash message"
    end

    context "failure to save" do
      it "should redirect to the new template"
      it "should display a sad flash message"
    end

  end

end