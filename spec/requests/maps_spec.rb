require 'spec_helper'

describe "Maps" do
  describe "GET /maps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get maps_path
      response.status.should be(200)
    end
  end
  
  describe "POST /maps" do
    pending "Should create an object"
  end
end
