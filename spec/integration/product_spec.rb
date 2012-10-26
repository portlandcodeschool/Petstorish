require 'capybara/rspec'

describe "Adding a product" do
  it "fills in product details" do
    visit '/products/new'
      fill_in 'product_name', :with => 'Steve-o-meter'
      fill_in 'product_description', :with => 'Measures the steves'
      fill_in 'product_price', :with => '12,131.00'
      attach_file "Steve", '/Users/pk/img.jpg'
      click_button 'Save'
      current_path.should eq("/products/new")
  end
end
