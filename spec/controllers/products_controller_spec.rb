require 'spec_helper'


describe ProductsController do
  let(:products) { [mock("product1"), mock("product2")] }
  let(:product) { mock_model(Product)}

  describe "GET index" do

    before(:each) do
      Product.stub(:order).and_return(products)
      products.stub(:page)
    end
    it "assigns all products to @products" do
      Product.should_receive(:order).and_return(products)
      get :index
    end

    it "should select the products/index template for rendering" do
      get :index
      response.should render_template('products/index')
    end

    it "should paginate the products" do
      products.should_receive(:page)
      get :index
    end
  end #GET index

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

  end #GET new

  describe "POST create" do
    let(:product) { mock_model(Product).as_new_record }

    before(:each) do
      Product.stub(:new).and_return(product)
      product.stub(:save).and_return("tubular")
      @user = mock(User, :admin => true)
      @user.stub(:admin?).and_return(true)
      controller.stub(:current_user).and_return @user
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

    end # successful save

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

    end #failure to save

  end #describe "post create"


  describe "POST update" do
    describe "with valid params" do

      before(:each) do
        @product = mock_model(Product).as_null_object
        Product.stub(:find).and_return(@product)
        @product.stub(:update_attributes).and_return(true)
      end

      it "updates the requested product" do
        @product.should_receive(:update_attributes)
        post :update, :id => @product.id
     end

      it "assigns the requested product as @option" do
        post :update, :id => @product.id
        assigns(:product).should eq @product
     end

      it "redirects to the product" do
        post :update, :id => @product.id
        response.should redirect_to(@product)
      end

    end #describe "with valid...

    describe "with invalid params" do

      before(:each) do
        @product = mock_model(Product).as_null_object
        Product.stub(:find).and_return(@product)
        @product.stub(:update_attributes).and_return(false)
      end

      it "re-renders the 'edit' template" do
        post :update, :id => @product.id
        response.should render_template('products/edit')
      end

      it "posts a sorry flash message" do
        post :update, :id => @product.id
        flash[:errors].should_not be_nil
      end
    end #describe "with invalid...
  end #describe "POST update...

  describe "GET edit" do

    before(:each) do
      @product = mock_model(Product)
      Product.should_receive(:find).and_return(@product)
    end

    it 'should find and return a product' do
      get :show, :id => @product.id
    end

    it 'should not save the product' do
      @product.should_not_receive(:save)
      get :show, :id => @product.id
    end

  end

  describe "GET category list" do
    context "good path" do

      before(:each) do
        @products = [mock_model(Product), mock_model(Product)]
        @products.stub(:page)
        Product.stub(:where).and_return(@products)
      end

      it "finds the products by category" do
        Product.should_receive(:where).and_return(@products)
        get :list, :category => 'pets'
      end

      it "renders index" do
        get :list, :category => 'pets'
        response.should render_template('products/index')
      end

      it "paginates the products" do
        @products.should_receive(:page)
        get :list, :category => "I LOVE TESTING FIFUN!!!"
      end
    end

    context "bad path" do


      before(:each) do
        Product.stub(:where).and_return([])
      end
      it "redirects to root" do
        get :list, :category => 'pets'
        response.should redirect_to :root
      end

      it "sends a flash message" do
        get :list, :category => 'pets'
        flash[:notice].should_not be_nil
      end

    end
  end

  describe "get search" do

    context "non-empty search" do

      before(:each) do
        @products = [mock(Product)]
        @products.stub(:page)
      end

      it "searches the database" do
        Product.should_receive(:where).and_return(@products)
        get :search, :query => "where the party at?"
      end

    end

    context "empty search" do

      before(:each) do
        Product.should_receive(:where).and_return([])
      end

      it "displays a sorry message" do
       get :search, :query => "?DJKLDSF"
       flash[:notice].should match('Sorry')
       end

      it "redirects to zombocom" do
        get :search, :query => "zombo?"
        response.should redirect_to :root
      end

    end
  end

  describe "using advanced search" do

    context "with results" do

      before(:each) do
        @products = [mock_model(Product)]
        Product.stub(:where).and_return(@products)
        @products.stub(:page).and_return(@products)
        @pars = {:query => 's', :options =>[:name, :description], :price => {:minimum => 0, :maximum => 100}}
      end

      it "should search database" do
        Product.should_receive(:where).and_return(@products)
        post :adv_search, @pars
      end

      it "should paginate the products" do
        @products.should_receive(:page)
        post :adv_search, @pars
      end


      it "should assign results to @products" do
        post :adv_search, @pars
        assigns(:products).should eq @products
      end

    end

    context "without results" do

   
    end

  end

end













