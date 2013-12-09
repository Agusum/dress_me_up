require 'spec_helper'

describe "garments/show" do
  before(:each) do
    @garment = assign(:garment, stub_model(Garment))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
