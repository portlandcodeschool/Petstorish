require 'capybara/rspec'
require 'spec_helper'

describe "Adding a new family of options to a new product" do

  describe "happy path" do

    it "saves the new family of options and displays it on the page", :js => true do
      visit '/products/new'
        fill_in 'family', :with => 'texture'
        fill_in 'value', :with => 'slimy'
        click_link('optSubmit')
        page.should have_content('Texture')
    end

    after(:all) do
      Option.find_by_family("texture").destroy
    end
  end

  describe "sad path" do

    context "the value already exists" do

      before(:all) do
        Option.create(:family => 'texture', :value => 'slimy')
      end

      it "produces an alert saying the value already exists", :js => true do
        visit '/products/new'
        fill_in 'family', :with => 'texture'
        fill_in 'value', :with => 'slimy'
        click_link('optSubmit')
        page.driver.browser.switch_to.alert.text.should have_content('Value already exists')
        page.driver.browser.switch_to.alert.accept
      end

      after(:all) do
        Option.find_by_family("texture").destroy
      end

    end

  end

end