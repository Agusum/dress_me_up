class Garment < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	validates_presence_of :name

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
end
