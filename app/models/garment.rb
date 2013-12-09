class Garment < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
