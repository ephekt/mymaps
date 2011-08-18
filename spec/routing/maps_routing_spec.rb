require "spec_helper"

describe MapsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/maps" }.should route_to(:controller => "maps", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/maps/new" }.should route_to(:controller => "maps", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/maps/1" }.should route_to(:controller => "maps", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/maps/1/edit" }.should route_to(:controller => "maps", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/maps" }.should route_to(:controller => "maps", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/maps/1" }.should route_to(:controller => "maps", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/maps/1" }.should route_to(:controller => "maps", :action => "destroy", :id => "1")
    end

  end
end
