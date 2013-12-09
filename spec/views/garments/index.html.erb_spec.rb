require 'spec_helper'

describe "garments/index" do
  before(:each) do
    assign(:garments, [
      stub_model(Garment),
      stub_model(Garment)
    ])
  end

  it "renders a list of garments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
