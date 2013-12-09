require 'spec_helper'

describe "garments/new" do
  before(:each) do
    assign(:garment, stub_model(Garment).as_new_record)
  end

  it "renders new garment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", garments_path, "post" do
    end
  end
end
