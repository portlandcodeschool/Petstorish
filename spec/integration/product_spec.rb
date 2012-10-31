require 'capybara/rspec'
require 'spec_helper'

describe "Adding a product" do

  context "happy path" do

    it "fills in all product details" do
      visit '/products/new'
        fill_in 'product_name', :with => 'Steve-o-meter'
        fill_in 'product_description', :with => 'Measures the steves'
        fill_in 'product_price', :with => 131.00
        select('pets', :from => 'product_category')
        attach_file('product_image', File.expand_path('test/images/img.jpg'))
        click_button 'Save'
        current_path.should match(/\/products\/\d+$/)
    end

  end

  context "sad path" do

    it "leaves fields empty" do
      visit '/products/new'
        fill_in 'product_name', :with => ''
        fill_in 'product_description', :with => ''
        fill_in 'product_price', :with => ''
        attach_file('product_image', File.expand_path('test/images/img.jpg'))
        click_button 'Save'
        current_path.should match(/\/products\/new$/)
        page.should have_content "error"
    end

  end

end

describe "edit a product" do
  context "rosy path" do
    it "makes some edits" do
      visit '/products/1/edit'
      fill_in 'product_name', :with => 'Steve-o-meter'
      fill_in 'product_description', :with => 'Measures the steves'
      fill_in 'product_price', :with => 131.00
      select('pets', :from => 'product_category')
      attach_file('product_image', File.expand_path('test/images/img.jpg'))
      click_button 'Save'
      current_path.should match('/products/1')
      page.should have_content('Steve-o-meter')
    end
    it "makes a new option via ajax", :js => true do
      visit '/products/1/edit'
      fill_in 'family', :with => "color"
      fill_in 'value', :with => "emerald"
      find('#optSubmit').click
      page.should have_content 'emerald'
    end
  end

  context "painful path" do
    it "tries to save bad data" do
      visit '/products/1/edit'
      fill_in 'product_name', :with => ''
      fill_in 'product_description', :with => 'Measures the steves'
      fill_in 'product_price', :with => ''
      select('pets', :from => 'product_category')
      attach_file('product_image', File.expand_path('test/images/img.jpg'))
      click_button 'Save'
      page.should have_content('errors')
    end
  end


end

describe "listing a product by category" do

  describe "happy path" do
    it "displays all products in that category" do
      pending
    end
  end

  describe "sad path" do
    it "redirects to the index page and displays a flash notice" do
      Product.stub(:where).and_return([])
      visit '/'
      click_link 'pets'
      current_path.should == '/'
      page.should have_content("We don't sell that.  Go to walmart.")
    end
  end
end

describe "searching for a product by name" do

  describe "with results" do

    it "displays results" do
      visit '/'
      fill_in 'query', :with => 'Steve'
      click_button 'search'
      current_path.should == '/s/'
      page.should have_content "Wonder"
    end

  end

end


