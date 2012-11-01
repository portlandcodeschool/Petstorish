require 'capybara/rspec'
require 'spec_helper'

describe "adding a product to a cart" do

  context "in a non-ajax style" do

    context "happy path" do

      it "displays the updated cart page" do
        visit '/products/1'
        fill_in 'Quantity:', :with => '2'
        find('#cartButton').click
        current_path.should match (/^\/carts\/\d+$/)
      end

    end

    context "sad path" do

      it "displays an error message on the product page" do
        visit '/products/1'
        find('#cartButton').click
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

describe "editing the cart" do



end
