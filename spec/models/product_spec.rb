require 'spec_helper'

describe Product do
  let(:product) { Product.new }

  it 'has a name field' do
    # product = Product.new
    product.name.should be_nil
  end

  it "has an image field" do
    product.image.should_not be_nil
  end

  context "validating presence of fields" do

    before(:each) do
      @valid_attributes = {
        :description => "Get yours now!",
        :name => "Steve",
        :price => "1 million dollars"
      }
      @product = Product.create
    end

    it 'should require name field' do
      @product.attributes = @valid_attributes.except(:name)
      @product.should_not be_valid
      @product.name = "steve"
      @product.should be_valid
    end


    it 'should have a description' do
      @product.attributes = @valid_attributes.except(:description)
      @product.should_not be_valid
      @product.description = "steve"
      @product.should be_valid
    end


    it 'should have a price' do
      @product.attributes = @valid_attributes.except(:price)
      @product.should_not be_valid
      @product.price = 12
      @product.should be_valid
    end

    it 'should not have a turtle field' do
      @product = Product.new
      expect { product.turtle }.to raise_error
    end

  end
end
