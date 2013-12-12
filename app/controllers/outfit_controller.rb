class OutfitController < ApplicationController

	def index
    @garments = Garment.all
    @garment = Garment.new(name: "Test", category: "Shirt")
    @outfit = @garment.get_outfit(@garments)
  end
end