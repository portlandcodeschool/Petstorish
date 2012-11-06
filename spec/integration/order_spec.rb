require 'capybara/rspec'
require 'spec_helper'

describe "user login to place an order" do

  before(:each) do
    @cart = FactoryGirl.create(:cart_with_line_items)
    CartsController.stub(:current_cart).and_return(@cart)
  end

  it "redirects the user to a login page" do
    pending
    visit '/cart'
    page.should have_css 'table.cart'
    puts "AAAAAAAAAAAAAAAAAA"
    puts @cart.line_items.length
    page.should have_css 'tr.line-item' # WHY DOESN'T THIS WORK?
    find('#checkoutButton').click # To be implemented

  end

end
