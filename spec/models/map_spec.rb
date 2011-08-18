require 'spec_helper'

describe Map do
  before(:each) do 
    @map = Map.new
  end

  it "should require a name and description" do
    @map.should_not be_valid
  end

  it "should not be valid without a name" do
    @map.should have(1).errors_on(:name)
  end

  it "should not be valid description" do
    @map.should have(1).errors_on(:description)
  end

  it "should be valid with a name and description" do
    @map.name = "Mikes Map"
    @map.description = "Mikes Description"
    @map.should be_valid
  end
end
