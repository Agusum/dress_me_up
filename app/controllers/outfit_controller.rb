class OutfitController < ApplicationController

	def index
	  @garments = Garment.all
	  @garment = Garment.new(name: "Test", category: "Shirt")
	  initial_outfit = {}
	  initial_outfit[:shirt] = Garment.find(params[:shirt]) if params[:shirt].present?
	  initial_outfit[:pants] = Garment.find(params[:pants]) if params[:pants].present?
	  initial_outfit[:shoes] = Garment.find(params[:shoes]) if params[:shoes].present?
	  #Rails.logger.debug "Name: #{initial_outfit[:pants].category}"
	  @outfit = @garment.get_outfit(initial_outfit, @garments)
	  @garments_shirts = @garment.get_garments(@garments, "Shirt")
	  @garments_pants = @garment.get_garments(@garments, "Pants")
	  @garments_shoes = @garment.get_garments(@garments, "Shoes")
  end
end