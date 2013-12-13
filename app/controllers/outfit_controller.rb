class OutfitController < ApplicationController

	def index
    @garments = Garment.all
    @garment = Garment.new(name: "Test", category: "Shirt")
    @initial_outfit = {}
    @outfit = @garment.get_outfit(@initial_outfit, @garments)
  end
end