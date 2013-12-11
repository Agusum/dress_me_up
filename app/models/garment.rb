class Garment < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	validates_presence_of :name
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

	def get_outfit(garments)
		outfit = {}
		garments.shuffle!

		garments.each do |garment|
			if garment[:category] == 'Shoes' && outfit[:shoes] == nil
				outfit[:shoes] = garment[:name]
			elsif garment[:category] == 'Pants' && outfit[:pants] == nil 
				outfit[:pants] = garment[:name]
			elsif garment[:category] == 'Shirt' && outfit[:shirt] == nil 
				outfit[:shirt] = garment[:name]
			end

			if outfit.length == 3
				break
			end
		end

		# while outfit.length < 3
		# 	garment = garments.sample
		# 	if outfit[:shirt] == nil && garment[:category] == 'Shirt'
		# 		outfit[:shirt] = garment[:name]
		# 	elsif outfit[:pants] == nil && garment[:category] == 'Pants'
		# 		outfit[:pants] = garment[:name]
		# 	elsif outfit[:shoes] == nil && garment[:category] == 'Shoes'
		# 		outfit[:shoes] = garment[:name]
		# 	end
		# end

		# garments.each do |garment|
		# 	if garment[:category] == 'Shoes' 
		# 		outfit[:shoes] = garment[:name]
		# 	end
		# 	if garment[:category] == 'Pants' 
		# 		outfit[:pants] = garment[:name]
		# 	end
		# 	if garment[:category] == 'Shirt' 
		# 		outfit[:shirt] = garment[:name]
		# 	end
		# end
		return outfit
	end
end
