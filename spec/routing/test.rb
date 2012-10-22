require 'spec_helper'

describe "routing to  stuff" do
  it "routes /:category to products#list" do
    { :get => "/steve" }.should route_to(
      :controller => "products",
      :action => "list",
      :category => "steve"
    )
  end

end
