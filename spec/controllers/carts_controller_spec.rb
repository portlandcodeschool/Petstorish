require 'spec_helper'

describe CartsController do

  describe "GET edit" do

    before(:each) do
      @cart = mock(Cart)
      controller.stub(:current_cart).and_return @cart 
      @cart.stub(:line_items).and_return []
    end

      it "assigns a cart to @cart" do
        get :edit, :id => 'steve' 
        assigns(:cart).should eq @cart
      end


    context "empty cart" do
    
      it "checks whether line_items is empty" do
        @cart.should_receive(:line_items).and_return []
        get :edit, :id => 234234234
      end

      it "should set a sad flash notice" do
        get :edit, :id => 2
        flash[:notice].should match /empty/
      end
    end


  end
end
