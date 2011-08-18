require 'spec_helper'

describe "maps/new.html.erb" do
  before(:each) do
    assign(:map, stub_model(Map,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => maps_path, :method => "post" do
      assert_select "input#map_name", :name => "map[name]"
      assert_select "input#map_description", :name => "map[description]"
    end
  end
end
