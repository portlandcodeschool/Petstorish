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
        :price => 1000.20,
        :category => "Family of Steves"
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


    it 'should have a category' do
      @product.attributes = @valid_attributes.except(:category)
      @product.should_not be_valid
      @product.category = 12
      @product.should be_valid
    end

    it 'should not have a turtle field' do
      @product = Product.new
      expect { product.turtle }.to raise_error
    end

  end

  context "checking validity of fields" do

    it "does not allow non-positive numbers" do

      @invalid_attributes= {
        :description => "Get yours now!",
        :name => "Steve",
        :price => -13,
        :category => "Family of Steves"
      }
      @product = Product.create

      @product.attributes = @invalid_attributes

      @product.should_not be_valid
      @product.price = 0
      @product.should_not be_valid

      @product.price = 12
      @product.should be_valid
    end

    it "does not allow more than two decimal places" do

      @invalid_attributes= {
        :description => "Get yours now!",
        :name => "Steve",
        :price => 13.523,
        :category => "Family of Steves"
      }
      @product = Product.create

      @product.attributes = @invalid_attributes
      @product.should_not be_valid

      @product.price = 13.52
      @product.should be_valid

      @product.price = 12.2
      @product.should be_valid

    end

  describe "Product#has_option" do
    let (:product) { Product.create(
      :description => "Get yours now!",
      :name => "Steve",
      :price => 1000.20,
      :category => "Family of Steves") }

    let (:option_assignment) {OptionAssignment.create(
      :product_id => product.id,
      :option_id => 1) }

    context "product with options" do
      it "returns true" do
        product.has_option(1).should == true
      end
    end

  end

end























end
