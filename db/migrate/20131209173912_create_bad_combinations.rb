class CreateBadCombinations < ActiveRecord::Migration
  def change
    create_table :bad_combinations, id: false do |t|
    	t.integer :garment_id
    	t.integer :bad_combination_id
    end
  end
end
