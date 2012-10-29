require 'spec_helper'

describe "products/new.haml" do

  # Not sure what to test here, given that we already have integration tests for this.

  it "displays flash errors if there are any" do
    pending "This should probably be an integration test, not a view test."
    render
    rendered.should have_selector('div#error_explanation')
  end

end