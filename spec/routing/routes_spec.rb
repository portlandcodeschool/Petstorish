require 'spec_helper'

describe "Go to category list" do
  it "routes /:category to products#list" do
    { :get => "/steve" }.should route_to(
      :controller => "products",
      :action => "list",
      :category => "steve"
    )
  end
end

describe "Products controller" do  
  it "displays a product" do
    {:get => "/products/9"}.should route_to(
      controller: "products",
      action: "show",
      id: "9"
    )
  end
  it "edits a product" do
    {get: "/products/9/edit"}.should route_to(
      controller: "products",
      action: "edit",
      id: "9"
    )
  end
end


describe "Displaying orders" do
  it "displays order list" do
    {get: "/orders"}.should route_to(
      controller: "orders",
      action: "index"
    )
  end
end
