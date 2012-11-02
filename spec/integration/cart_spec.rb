require 'capybara/rspec'
require 'spec_helper'

describe "stuff of the cart" do

  before(:each) do
    visit '/products/1'
    fill_in 'Quantity:', :with => '2'
    find('#cartButton').click
  end

  describe "adding a product to a cart" do


    context "in a non-ajax style" do


      context "happy path" do

        it "displays the updated cart page" do
          current_path.should eq '/cart'
        end

        it "should display the line item" do
          page.should have_content('funzone')
        end

        it "should have an update button" do
          page.should have_content('update')
        end

        it "should display the price of the line item" do
          page.should have_content('2.00') 
        end

        it "should have a checkout link" do
          page.should have_content('checkout')
        end

        it "should have a Checkout link" do
          page.should have_content('Checkout')
        end

        it "should have a dropdown box for options" do
          page.should have_css('.option-select')
        end

      end

      context "sad path" do

        it "displays an error message on the product page" do
          current_path.should == '/products/1'
          page.should have_content('error')
        end

      end

    end

    context "ajax style" do

      it "creates the cart display within the current page" do
        pending
      end

    end


  end
end












