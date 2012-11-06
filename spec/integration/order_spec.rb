require 'spec_helper'
require 'capybara/rspec'


describe "user login to place an order" do

  before(:each) do
    @cart = FactoryGirl.create(:cart_with_line_items)
    CartsController.any_instance.stub(:current_cart).and_return(@cart)
  end

  it "redirects the user to a login page" do
    visit '/cart'
    page.should have_css 'table.cart'
    puts "AAAAAAAAAAAAAAAAAA"
    puts page.methods(false).sort
    puts page.inspect
    puts @cart.line_items.length
    page.should have_css 'tr.line-item' # WHY DOESN'T THIS WORK?
    find('#checkoutButton').click # To be implemented

  end

end
