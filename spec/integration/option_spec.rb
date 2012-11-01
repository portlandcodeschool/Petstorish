require 'capybara/rspec'
require 'spec_helper'

def log_in_admin
 visit '/admin'
 fill_in 'Email', :with => 'testuser@test.com'
 fill_in 'Password', :with => '000000009'
 click_button('Sign in')
end

describe "Adding a new family of options to a new product" do

  describe "happy path" do
    before(:each) do
      log_in_admin
    end
    it "saves the new family of options and displays it on the page", :js => true do
      visit '/products/new'
        fill_in 'family', :with => 'texture'
        fill_in 'value', :with => 'slimy'
        # find doesn't need the a to have an href. href = "#" makes the page go to
        # the top instead of staying where it is, which defeats the point of
        # using ajax.
        find('#optSubmit').click
        page.should have_content('Texture')
    end

    after(:all) do
      Option.find_by_family("texture").destroy
    end
  end

  describe "sad path" do
    before(:each) do
      log_in_admin
    end
    context "the value already exists" do

      before(:all) do
        Option.create(:family => 'texture', :value => 'slimy')
      end

      it "produces an alert saying the value already exists", :js => true do
        visit '/products/new'
        fill_in 'family', :with => 'texture'
        fill_in 'value', :with => 'slimy'
        find('#optSubmit').click 
        page.driver.browser.switch_to.alert.text.should have_content('Value already exists')
        page.driver.browser.switch_to.alert.accept
      end

      after(:all) do
        Option.find_by_family("texture").destroy
      end

    end

  end

end
