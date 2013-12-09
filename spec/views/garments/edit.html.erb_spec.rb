require 'spec_helper'

describe "garments/edit" do
  before(:each) do
    @garment = assign(:garment, stub_model(Garment))
  end

  it "renders the edit garment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", garment_path(@garment), "post" do
    end
  end
end
