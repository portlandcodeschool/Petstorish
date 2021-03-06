require 'capybara/rspec'
require 'spec_helper'


def log_in_admin
 visit '/admin'
 fill_in 'Email', :with => 'testuser@test.com'
 fill_in 'Password', :with => '000000009'
 click_button('Sign in')
end

describe "viewing a product" do
  it "displays various fields" do
    visit '/products/1'
      page.should have_css('div.attribute#product')
      page.should have_css('div.attribute#category')
      page.should have_css('div.attribute#price')
      page.should have_css('div.attribute#description')
  end
end

describe "Adding a product" do
  before(:each) do
    log_in_admin
  end
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
  before(:each) do 
    log_in_admin
  end
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
    describe "JS ajax testing" do
      it "makes a new option via ajax", :js => true do
        visit '/products/1/edit'
        fill_in 'family', :with => "color"
        fill_in 'value', :with => "emerald"
        find('#optSubmit').click
        page.should have_content 'emerald'
      end
      after(:all) do
        Option.find_by_value("emerald").destroy
      end
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
      visit '/'
      click_link 'pets'
      current_path.should == '/pets'
      page.has_css?('div.product-listing')
      all('div.product-listing').first.click_link('Show')
      within('#category') do
        page.should have_content('pets')
      end
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

    it "displays results", :js => true do
      visit '/'
      within '.basic-search' do
        fill_in 'query', :with => 'Steve'
        click_button 'SearchButton'
      end
      current_path.should == '/s/Steve'
      page.should have_content "Wonder"
    end

  end

  describe "with no results" do

    it "redirects to the index page and displays a flash notice", :js => true do
      visit '/'
      within '.basic-search' do
        fill_in 'query', :with => 'zxcvqwbk'
        click_button 'SearchButton'
      end
      current_path.should == '/'
      page.should have_css 'div.notice'
    end

  end

end

describe "advanced search" do

  it "by name, by description" do
    visit '/'
    click_link 'Advanced Search'
    within '.search' do
      fill_in 'query', :with => 'funzone crazypants'
      click_button 'OverlaySearchButton'
    end
    current_path.should == '/s/'
    page.should have_content 'funzone'
  end
  it "by name, not description" do
    visit '/'
    click_link 'Advanced Search'
    within '.search' do
      fill_in 'query', :with => 'funzone'
      click_button 'OverlaySearchButton'
    end
    current_path.should == '/s/'
    page.should have_content 'funzone'
  end
  it "not name, by description" do
    visit '/'
    click_link 'Advanced Search'
    within '.search' do
      fill_in 'query', :with => 'crazypants'

      click_button 'OverlaySearchButton'
    end
    current_path.should == '/s/'
    page.should have_content 'funzone'
  end
  it "not name, not description" do
    visit '/'
    click_link 'Advanced Search'
    within '.search' do
      page.select("10", :from => 'price_maximum')
      click_button 'OverlaySearchButton'
    end
    current_path.should == '/s/'
    page.should have_content 'funzone'
  end
end
