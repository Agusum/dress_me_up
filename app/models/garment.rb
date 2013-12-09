class Garment < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	validates_presence_of :name

	CATEGORY = ['Shoes', 'Pants', 'Shirt'].sort
end
