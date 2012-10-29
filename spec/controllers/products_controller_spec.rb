require 'spec_helper'

describe ProductsController do
  let(:products) { [mock("product1"), mock("product2")] }
  let(:product) { mock_model(Product)}

  describe "GET index" do

    it "assigns all products to @products" do
      Product.should_receive(:all).and_return(products)
      get :index
    end

    it "should select the products/index template for rendering" do
      Product.stub(:all).and_return(products)
      get :index
      response.should render_template('products/index')
    end

  end

  describe "GET products/:id" do

    before(:each) do
      @product = mock_model(Product)
      Product.should_receive(:find).with("12").and_return(@product)
    end

    it 'should find and return a product' do
      get :show, :id => '12'
    end

    it 'should not save the product' do
      @product.should_not_receive(:save)
      get :show, :id => '12'
    end

  end #describe "GET products/:id"

  describe "GET new" do

    it "should call the new method on Product" do
      Product.should_receive(:new).and_return(product)
      get :new
    end

    it "should render the new template" do
      get :new
      response.should render_template('products/new')
    end

    it "has the proper params" do
      get :new
      controller.params.should_not be_nil
      controller.params[:action].should eq "new"
      controller.params[:controller].should eq "products"
    end

  end

  describe "POST create" do
    let(:product) { mock_model(Product).as_new_record }

    before(:each) do
      Product.stub(:new).and_return(product)
      product.stub(:save).and_return("tubular")
    end

    context "successful save" do

      it "has the proper params" do
        post :create, {:product => {:name => "so and so", :description => "from wherever wherever", :price => 12.99}}
        controller.params.should_not be_nil
        controller.params[:action].should eq "create"
        controller.params[:controller].should eq "products"
        controller.params[:product].should_not be_nil
      end

      it "saves the new product" do
        Product.should_receive(:new)
        product.should_receive(:save)
        post :create
      end

      it "redirects to the show template" do
        post :create
        response.should redirect_to(product)
      end

      it "displays a happy flash message" do
        post :create
        flash[:notice].should match('success')

     end

    end

    context "failure to save" do

      before(:each) do
        product.stub(:save).and_return(false)
      end

      it "redirects to the new template" do
        post :create
        response.should redirect_to(:action => "new")
      end

      it "displays a sad flash message" do
        post :create
        flash[:errors].should_not be_nil
      end

    end

  end #describe "post create"

end
