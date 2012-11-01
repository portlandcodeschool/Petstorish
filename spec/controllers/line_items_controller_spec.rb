require 'spec_helper'

describe LineItemsController do

  describe "POST update" do


    describe "with valid params" do

      before(:each) do
        @line_item = mock_model(LineItem)
        LineItem.stub(:find).and_return(@line_item)
        @line_item.stub(:update_attributes).and_return(true)
        @params = {:id => @line_item.id, :cart_id => 11}
      end

      it "updates the requested line_item" do
        @line_item.should_receive(:update_attributes)
        post :update, @params
     end

      it "assigns the requested line_item as @line_item" do
        post :update, @params
        assigns(:line_item).should eq @line_item
     end


      it "redirects to the cart" do
        post :update, @params
        response.should redirect_to(cart_path)
      end


    end #describe "with valid...

    describe "with invalid params" do

      before(:each) do
        @line_item = mock_model(LineItem)
        LineItem.stub(:find).and_return(@line_item)
        @line_item.stub(:update_attributes).and_return(false)
        @params = {:id => @line_item.id, :cart_id => 11}
        @steve.stub(:messages).and_return('hie')
        @line_item.stub(:errors).and_return(@steve)
      end

      it "displays a flash error" do
        post :update, @params
        flash[:errors].should_not be_empty
      end

      it "redirects to the cart" do
        post :update, @params
        response.should redirect_to(cart_path)
      end
 
    end #describe "with invalid...
  end #POST update
  
end #file
