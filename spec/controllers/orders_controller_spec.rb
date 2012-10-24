require 'spec_helper'

describe OrdersController do

  describe "POST create" do
    let(:order) { mock_model(Order).as_null_object }

    before do
      Order.stub(:new).and_return(order)
    end

    it "creates a new order" do
      Order.should_receive(:new).and_return(order)
      post :create
    end

    it "saves the order" do
      order.should_receive(:save)
      post :create
    end

    context "when the order saves successfully" do
      it "sets a flash[:notice] message" do
        post :create
        flash[:notice].should eq("Your order has been placed.")
      end

      it "redirects to the Orders index" do
        post :create
        response.should redirect_to(:action => "index")
      end
    end

    context "when the order fails to save" do

      before do
        order.stub(:save).and_return(false)
      end

      it "sets a flash[:notice] message" do
        pending "figure out how the cart works"
        post :create
        flash[:notice].should eq("There was a problem placing your order. Please try again.")
      end

      it "returns the user to their cart" do
        pending "figure out how the cart works"
      end

    end
  end
end