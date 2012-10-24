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

  describe "GET new" do
    it "should call the new method on Product" do
      Product.should_receive(:new).and_return(product)
      get :new
    end

    it "should render the new template" do
      get :new
      response.should render_template('products/new')
    end
  end

  describe "POST create" do
      
    
    before(:each) do
      @product = mock_model(Product)
      Product.stub(:new).and_return(@product)
      @product.stub(:save).and_return("tubular")
    end

   
    context "successful save" do
      
      it "should save the new product" do
        Product.should_receive(:new)
        @product.should_receive(:save)
        post :create
      end
      
      
      it "should redirect to the show template" do
        post :create
        response.should redirect_to(@product)
      end
     
      it "should display a happy flash message" do
        post :create
        flash[:notice].should_not be_blank

     end
        
    end

    context "failure to save" do
   
      it "should redirect to the new template" do
        post :create
        response.should redirect_to(@product)
      end
   
      it "should display a sad flash message"
   
    end

  end #describe "post create"

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

end
