require 'spec_helper'

describe "maps/edit.html.erb" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => maps_path(@map), :method => "post" do
      assert_select "input#map_name", :name => "map[name]"
      assert_select "input#map_description", :name => "map[description]"
    end
  end
end
