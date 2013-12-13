class Garment < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	validates_presence_of :name
	#validates_presence_of :image
	validates_presence_of :category

	has_and_belongs_to_many :good_combinations,
													class_name: 'Garment',
													join_table: :good_combinations,
													foreign_key: :garment_id,
													association_foreign_key: :good_combination_id

	has_and_belongs_to_many :bad_combinations,
													class_name: 'Garment',
													join_table: :bad_combinations,
													foreign_key: :garment_id,
													association_foreign_key: :bad_combination_id

	CATEGORY = ['Shoes', 'Pants', 'Shirt'].sort

	def get_outfit(outfit, garments) #garments is an array of garment objects
		#outfit is an object which keys are the clothes category and which values are garment objects.
		garments.shuffle!

		garments.each do |garment|
			if garment[:category] == 'Shoes' && outfit[:shoes] == nil
				if !check_bad_combination(outfit, garment) && !check_bad_combination2(outfit, garment)
					outfit[:shoes] = garment
				end
			elsif garment[:category] == 'Pants' && outfit[:pants] == nil
				if !check_bad_combination(outfit, garment) && !check_bad_combination2(outfit, garment)
					outfit[:pants] = garment
				end
			elsif garment[:category] == 'Shirt' && outfit[:shirt] == nil 
				if !check_bad_combination(outfit, garment) && !check_bad_combination2(outfit, garment)
					outfit[:shirt] = garment
				end
			end

			if outfit.length == 3
				break
			end
		end

		return outfit
	end

	def check_bad_combination(outfit, garment)
		garment.bad_combinations.each do |bad|
			outfit.each do |key, outfit_garment|
				if bad[:name] == outfit_garment[:name]
					return true
				end
			end
		end
		#Borrar tres lineas para simplificar
		return false
	end

	def check_bad_combination2(outfit, garment)
		outfit.each do |key, outfit_garment|
			outfit_garment.bad_combinations.each do |bad|
				if bad[:name] == garment[:name]
					return true
				end
			end
		end

		return false
	end

end
