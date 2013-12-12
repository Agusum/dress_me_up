require 'spec_helper'

describe Garment do
	let(:garment_shirt) { Garment.new(name: 'Camiseta Negra', category: 'Shirt') }
	let(:garment_pants) { Garment.new(name: 'Vaqueros', category: 'Pants') }
	let(:garment_shoes) { Garment.new(name: 'Zapatos', category: 'Shoes') }
	let(:garment_no_match) { Garment.new(name: 'Camiseta Roja', category: 'Shirt') }

	describe "with valid attributes" do
    it "should be valid" do
      expect(garment_shirt).to be_valid
    end
  end

  describe "is invalid" do
	  it "without a name using build (Factory Girl)" do
      expect(build(:garment, name: nil)).to_not be_valid
    end

    it "without a name" do
		  garment_shirt[:name] = nil
      expect(garment_shirt).to_not be_valid
    end

    it "without a category" do
    	garment_shirt[:category] = nil
      expect(garment_shirt).to_not be_valid
    end
  end

  describe 'having an incomplete set of garments' do
  	it "should create a random outfit" do
		  garments = []
		  garments << garment_shirt
		  garments << garment_pants

	  	outfit = garment_shirt.get_outfit(garments)
	    expect(outfit[:shoes]).to eq(nil)
	    expect(outfit[:pants][:name]).to eq('Vaqueros')
	    expect(outfit[:shirt][:name]).to eq('Camiseta Negra')
	  end
  end

	describe 'having a complete set of garments' do

		before(:each) do
		  @garments = []
		  @garments << garment_shirt
		  @garments << garment_pants
		  @garments << garment_shoes

		  garment_no_match.bad_combinations << garment_pants
		  garment_pants.bad_combinations << garment_no_match
	  end

	  it "should create a random outfit" do
	  	outfit = garment_shirt.get_outfit(@garments)
	    expect(outfit[:shoes][:name]).to eq('Zapatos')
	    expect(outfit[:pants][:name]).to eq('Vaqueros')
	    expect(outfit[:shirt][:name]).to eq('Camiseta Negra')
	  end

	  it "detects a bad combination" do
		  outfit = {}
		  outfit[:shirt] = garment_shirt
		  outfit[:pants] = garment_pants
		  outfit[:shoes] = garment_shoes

		  expect(garment_shirt.check_bad_combination(outfit, garment_no_match)).to eq(true)
	  end

	  it "doesn't detect a bad combination when there's nothing in the outfit yet" do 
	  	empty_outfit = {}

	  	expect(garment_shirt.check_bad_combination(empty_outfit, garment_no_match)).to eq(false)

	  end

	  it "should not include bad combinations in the outfit" do 
		  @garments << garment_no_match

		  outfit = garment_shirt.get_outfit(@garments)
		  outfit[:shirt] = garment_no_match
		  expect(outfit[:shoes][:name]).to eq('Zapatos')
	    expect(outfit[:pants][:name]).to eq(nil)
	    expect(outfit[:shirt][:name]).to eq('Camiseta Roja')

	  end
	end
end
