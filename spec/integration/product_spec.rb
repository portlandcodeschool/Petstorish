require 'capybara/rspec'

describe "Adding a product" do

  context "happy path" do

    it "fills in all product details" do
      visit '/products/new'
        fill_in 'product_name', :with => 'Steve-o-meter'
        fill_in 'product_description', :with => 'Measures the steves'
        fill_in 'product_price', :with => 131.00
        select('pets', :from => 'product_category')  
        attach_file 'product_image', '/Users/pk/img.jpg'
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
        attach_file 'product_image', '/Users/pk/img.jpg'
        click_button 'Save'
        current_path.should match(/\/products\/new$/)
    end

  end

end
