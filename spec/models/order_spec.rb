require 'spec_helper'

describe Order do
 
  context "validating presence of fields" do

    before(:each) do 
      @valid_attributes = {
        :status => "shipped",
        :user_id => "9"
      }
      @order = Order.create
    end

    it 'should require a user_id' do
      @order.attributes = @valid_attributes.except(:user_id)
      @order.should_not be_valid
      @order.user_id = "9"
      @order.should be_valid
    end

    it 'should have a status' do
      @order.attributes = @valid_attributes.except(:status)
      @order.should_not be_valid
      @order.status = "cart"
      @order.should be_valid
    end

    it 'should not have a turtle field' do
      @order = Order.new
      expect { order.turtle }.to raise_error
    end 
  
  end
end
