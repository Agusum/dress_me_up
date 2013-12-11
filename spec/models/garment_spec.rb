require 'spec_helper'

describe Garment do
	describe "with valid attributes" do
    it "should be valid" do
    	garment_ok = Garment.new
			garment_ok[:name] = 'Camiseta Negra'
			garment_ok[:category] = 'Shirt'
      expect(garment_ok).to be_valid
    end
  end

  describe "is invalid" do
  	before(:each) do
	    @garment_full = Garment.new
			@garment_full[:name] = 'Camiseta Negra'
			@garment_full[:category] = 'Shirt'
	  end

	  it "without a name using build" do
      expect(build(:garment, name: nil)).to_not be_valid
    end

    it "without a name" do
		  @garment_full[:name] = nil
      expect(@garment_full).to_not be_valid
    end

    it "without a category" do
    	@garment_full[:category] = nil
      expect(@garment_full).to_not be_valid
    end
  end

  describe 'having an incomplete set of garments' do
  	it "should create a random outfit" do
  		@garment_shirt = Garment.new
		  @garment_shirt[:name] = 'Camiseta Negra'
		  @garment_shirt[:category] = 'Shirt'
		  @garment_pants = Garment.new
		  @garment_pants[:name] = 'Vaqueros'
		  @garment_pants[:category] = 'Pants'
		  @garments = []
		  @garments << @garment_shirt
		  @garments << @garment_pants

	  	outfit = @garment_shirt.get_outfit(@garments)
	    expect(outfit[:shoes]).to eq(nil)
	    expect(outfit[:pants][:name]).to eq('Vaqueros')
	    expect(outfit[:shirt][:name]).to eq('Camiseta Negra')
	  end
  end

	describe 'having a complete set of garments' do
		before(:each) do
			@garment_shirt = Garment.new
		  @garment_shirt[:name] = 'Camiseta Negra'
		  @garment_shirt[:category] = 'Shirt'
		  @garment_pants = Garment.new
		  @garment_pants[:name] = 'Vaqueros'
		  @garment_pants[:category] = 'Pants'
		  @garment_shoes = Garment.new
		  @garment_shoes[:name] = 'Zapatos'
		  @garment_shoes[:category] = 'Shoes'
		  @garments = []
		  @garments << @garment_shirt
		  @garments << @garment_pants
		  @garments << @garment_shoes

		  @garment_no_match = Garment.new
	  	@garment_no_match[:name] = 'Camiseta Roja'
		  @garment_no_match[:category] = 'Shirt'
		  @garment_no_match.bad_combinations << @garment_pants
	  end

	  it "should create a random outfit" do
	  	outfit = @garment_shirt.get_outfit(@garments)
	    expect(outfit[:shoes][:name]).to eq('Zapatos')
	    expect(outfit[:pants][:name]).to eq('Vaqueros')
	    expect(outfit[:shirt][:name]).to eq('Camiseta Negra')
	  end

	  it "detects a bad combination" do
		  @outfit = {}
		  @outfit[:shirt] = @garment_shirt
		  @outfit[:pants] = @garment_pants
		  @outfit[:shoes] = @garment_shoes

		  expect(@garment_shirt.check_bad_combination(@outfit, @garment_no_match)).to eq(true)
	  end

	  it "doesn't detect a bad combination when there's nothing in the outfit yet" do 
	  	empty_outfit = {}

	  	expect(@garment_shirt.check_bad_combination(empty_outfit, @garment_no_match)).to eq(false)

	  end

	  it "should not include bad combinations in the outfit" do 
		  @garments << @garment_no_match

		  outfit = @garment_shirt.get_outfit(@garments)
	    expect(outfit[:shirt][:name]).to eq('Camiseta Negra')
	  end
	end
end
