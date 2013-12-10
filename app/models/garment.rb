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
		garments.each do |garment|
			if garment[:category] == 'Shoes' 
				outfit[:shoes] = garment[:name]
			end
			if garment[:category] == 'Pants' 
				outfit[:pants] = garment[:name]
			end
			if garment[:category] == 'Shirt' 
				outfit[:shirt] = garment[:name]
			end
		end
		return outfit
	end
end
