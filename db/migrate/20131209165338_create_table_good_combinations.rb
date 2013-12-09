class CreateTableGoodCombinations < ActiveRecord::Migration
  def change
    create_table :good_combinations, id: false do |t|
    	t.integer :garment_id
    	t.integer :good_combination_id
    end
  end
end
