require 'capybara/rspec'
require 'spec_helper'

describe "adding the first product to a new cart" do

  context "in a non-ajax style" do

    it "displays the updated cart page" do
      visit '/products/1'
      find('#cartButton').click
      current_path.should match (/^\/carts\/\d+$/)
    end

  end

  context "ajax style" do

    it "creates the cart display within the current page" do
      pending
    end

  end

end