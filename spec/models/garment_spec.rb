require 'spec_helper'

describe Garment do
	describe "with valid attributes" do
    it "should be valid" do
    	garment_ok = Garment.new
			garment_ok[:name] = 'Jersey Negro'
			garment_ok[:category] = 'Shirt'
      expect(garment_ok).to be_valid
    end
  end

  describe "is invalid" do
  	before(:each) do
	    @garment_full = Garment.new
			@garment_full[:name] = 'Jersey Negro'
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
  		@garment_jersey = Garment.new
		  @garment_jersey[:name] = 'Jersey Negro'
		  @garment_jersey[:category] = 'Shirt'
		  @garment_pants = Garment.new
		  @garment_pants[:name] = 'Vaqueros'
		  @garment_pants[:category] = 'Pants'
		  @garments = []
		  @garments << @garment_jersey
		  @garments << @garment_pants

	  	outfit = @garment_jersey.get_outfit(@garments)
	    expect(outfit[:shoes]).to eq(nil)
	    expect(outfit[:pants][:name]).to eq('Vaqueros')
	    expect(outfit[:shirt][:name]).to eq('Jersey Negro')
	  end
  end

	describe 'having a complete set of garments' do
		before(:each) do
			@garment_jersey = Garment.new
		  @garment_jersey[:name] = 'Jersey Negro'
		  @garment_jersey[:category] = 'Shirt'
		  @garment_pants = Garment.new
		  @garment_pants[:name] = 'Vaqueros'
		  @garment_pants[:category] = 'Pants'
		  @garment_shoes = Garment.new
		  @garment_shoes[:name] = 'Zapatos'
		  @garment_shoes[:category] = 'Shoes'
		  @garments = []
		  @garments << @garment_jersey
		  @garments << @garment_pants
		  @garments << @garment_shoes
	  end

	  it "should create a random outfit" do
	  	outfit = @garment_jersey.get_outfit(@garments)
	    expect(outfit[:shoes][:name]).to eq('Zapatos')
	    expect(outfit[:pants][:name]).to eq('Vaqueros')
	    expect(outfit[:shirt][:name]).to eq('Jersey Negro')
	  end

	  it "detects a bad combination" do
	  	@garment_no_match = Garment.new
	  	@garment_no_match[:name] = 'Jersey Rojo'
		  @garment_no_match[:category] = 'Shirt'
		  @garment_no_match.bad_combinations << @garment_pants
		  @outfit = {}
		  @outfit[:shirt] = @garment_jersey
		  @outfit[:pants] = @garment_pants
		  @outfit[:shoes] = @garment_shoes

		  expect(@garment_jersey.check_bad_combination(@outfit, @garment_no_match)).to eq(true)
	  end

	  it "doesn't detect a bad combination when there's nothing in the outfit yet" do 
	  	empty_outfit = {}
	  	@garment_no_match = Garment.new
	  	@garment_no_match[:name] = 'Jersey Rojo'
		  @garment_no_match[:category] = 'Shirt'
		  @garment_no_match.bad_combinations << @garment_pants

	  	expect(@garment_jersey.check_bad_combination(empty_outfit, @garment_no_match)).to eq(false)

	  end

	  it "should not include bad combinations in the outfit" do 
	  	@garment_no_match = Garment.new
	  	@garment_no_match[:name] = 'Jersey Rojo'
		  @garment_no_match[:category] = 'Shirt'
		  @garment_no_match.bad_combinations << @garment_pants
		  @garments << @garment_no_match
		  outfit = @garment_jersey.get_outfit(@garments)
	    expect(outfit[:shirt][:name]).to eq('Jersey Negro')
	  end
	end
end
